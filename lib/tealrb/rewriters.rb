# frozen_string_literal: true

require 'parser/current'

module TEALrb
  class MethodRewriter < Parser::TreeRewriter
    def on_def(node)
      r = remove node.loc.name
      r.remove node.loc.keyword
      r.remove node.loc.end
      super
    end

    def on_args(node)
      remove(node.loc.expression) if node.loc.expression
      super
    end

    def on_send(node)
      remove node.loc.selector if node.loc.selector.source == 'subroutine' || node.loc.selector.source == 'teal'
      super
    end
  end

  class AssignRewriter < Parser::TreeRewriter
    def on_lvasgn(node)
      rh = Parser::Source::Range.new(
        node.loc.expression.source_buffer,
        node.loc.operator.end_pos + 1,
        node.loc.expression.end_pos
      )

      wrap(rh, '-> { ', ' }')
      super
    end

    def on_lvar(node)
      insert_after(node.loc.name, '.call')
      super
    end

    def on_ivasgn(node)
      rh = Parser::Source::Range.new(
        node.loc.expression.source_buffer,
        node.loc.operator.end_pos + 1,
        node.loc.expression.end_pos
      )

      wrap(rh, '-> { ', ' }')
      super
    end

    def on_ivar(node)
      insert_after(node.loc.name, '.call') unless node.loc.name.source == '@teal'
      super
    end
  end

  class ComparisonRewriter < Parser::TreeRewriter
    def on_send(node)
      if TEALrb::Opcodes::BINARY_OPCODE_METHOD_MAPPING.keys.map(&:to_s).include? node.loc.selector.source
        wrap(node.loc.expression, '(', ')')
      end
      super
    end
  end

  class OpRewriter < Parser::TreeRewriter
    def on_and(node)
      wrap(node.children[1].loc.expression, '(', ')')

      op_loc = node.loc.operator
      op_loc = op_loc.resize(3) if op_loc.resize(3).source == '&& '

      replace(op_loc, '.boolean_and')

      super
    end

    def on_or(node)
      replace(node.loc.operator, '.boolean_or')
      super
    end

    OPCODE_METHODS = TEALrb::Opcodes.instance_methods.freeze

    def on_const(node)
      @skips = 1 if node.loc.name.source == 'Txna'
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
      elsif meth_name == :comment
        @skips = 1
      end
      super
    end

    def handler_missing(node)
      if %i[int str sym].include? node&.type
        @skips ||= 0
        @skips -= 1
        if @skips.negative?
          case node&.type
          when :int
            wrap(node.loc.expression, 'int(', ')')
          when :str
            wrap(node.loc.expression, 'byte(', ')')
          when :sym
            wrap(node.loc.expression, 'label(', ')') if node.loc.expression.source[/^:/]
          end
        end
      end
      super
    end
  end

  class IfRewriter < Parser::TreeRewriter
    def on_if(node)
      case node.loc.keyword.source
      when 'if'
        replace(node.loc.keyword, 'IfBlock.new(@teal, ')
      when 'elsif'
        replace(node.loc.keyword, 'end.elsif(')
      end

      cond_expr = node.children.first.loc.expression
      replace(cond_expr, "#{cond_expr.source} ) do")

      replace(node.loc.else, 'end.else do') if node.loc.else && node.loc.else.source == 'else'
      super
    end
  end
end
