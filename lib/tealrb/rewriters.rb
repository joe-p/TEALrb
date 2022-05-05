# frozen_string_literal: true

module TEALrb
  class Rewriter < Parser::TreeRewriter
    include RuboCop::AST::Traversal
  end

  class MethodRewriter < Rewriter
    def on_def(node)
      replace node.source_range, node.body.source
      super
    end

    def on_send(node)
      remove node.loc.selector if node.loc.selector.source == 'subroutine' || node.loc.selector.source == 'teal'
      super
    end
  end

  class AssignRewriter < Rewriter
    def on_lvasgn(node)
      wrap(node.children[1].source_range, '-> { ', ' }')
      super
    end

    def on_lvar(node)
      insert_after(node.loc.name, '.call')
      super
    end

    def on_ivasgn(node)
      wrap(node.children[1].source_range, '-> { ', ' }')
      super
    end

    def on_ivar(node)
      insert_after(node.loc.name, '.call') unless node.loc.name.source == '@teal'
      super
    end
  end

  class ComparisonRewriter < Rewriter
    def on_send(node)
      if TEALrb::Opcodes::BINARY_OPCODE_METHOD_MAPPING.keys.map(&:to_s).include? node.loc.selector.source
        wrap(node.source_range, '(', ')')
      end
      super
    end
  end

  class OpRewriter < Rewriter
    def initialize
      @skips = 0
      super
    end

    def on_and(node)
      wrap(node.children[1].source_range, '(', ')')

      op_loc = node.loc.operator
      op_loc = op_loc.resize(3) if op_loc.resize(3).source == '&& '

      replace(op_loc, '.boolean_and')

      super
    end

    def on_or(node)
      wrap(node.children[1].source_range, '(', ')')

      op_loc = node.loc.operator
      op_loc = op_loc.resize(3) if op_loc.resize(3).source == '|| '

      replace(op_loc, '.boolean_and')
      super
    end

    OPCODE_METHODS = TEALrb::Opcodes.instance_methods.freeze

    def on_const(node)
      @skips = 1 if %w[Txna Gtxn AppArgs].include? node.loc.name.source
      super
    end

    def on_send(node)
      meth_name = node.loc.selector.source.to_sym

      if OPCODE_METHODS.include? meth_name
        if meth_name[/(byte|int)cblock/]
          @skips = node.children.size - 2
        else
          params = TEALrb::Opcodes.instance_method(meth_name).parameters
          @skips = params.count { |param| param[0] == :req }
        end
      elsif %i[comment placeholder].include? meth_name
        @skips = 1
      end
      super
    end

    def on_int(node)
      wrap(node.source_range, 'int(', ')') if (@skips -= 1).negative?
      super
    end

    def on_str(node)
      wrap(node.source_range, 'byte(', ')') if (@skips -= 1).negative?
      super
    end

    def on_sym(node)
      wrap(node.source_range, 'label(', ')') if node.source_range.source[/^:/] && (@skips -= 1).negative?
      super
    end
  end

  class IfRewriter < Rewriter
    def on_if(node)
      case node.loc.keyword.source
      when 'if'
        replace(node.loc.keyword, 'IfBlock.new(@teal, ')
      when 'elsif'
        replace(node.loc.keyword, 'end.elsif(')
      end

      cond_expr = node.children.first.source_range
      replace(cond_expr, "#{cond_expr.source} ) do")

      replace(node.loc.else, 'end.else do') if node.loc.else && node.loc.else.source == 'else'
      super
    end
  end
end
