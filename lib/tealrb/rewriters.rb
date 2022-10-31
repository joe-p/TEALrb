# frozen_string_literal: true

module TEALrb
  module Rewriters
    class Rewriter < Parser::TreeRewriter
      include RuboCop::AST::Traversal
      attr_reader :contract

      def rewrite(processed_source, contract)
        @comments = processed_source.comments
        @contract = contract
        super(processed_source.buffer, processed_source.ast)
      end
    end

    class CommentRewriter < Rewriter
      def process(_)
        @comments.each do |comment|
          line = @source_rewriter.source_buffer.source_lines[comment.loc.expression.line - 1].strip

          next unless comment.inline? && comment.text[%r{^#\s*//}]

          inline_comment = line[/^#/].nil?
          content = comment.text.sub('# ', '')
          content.sub!('//', '')

          replace comment.loc.expression, "; comment(%q(#{content}), inline: #{inline_comment})"
        end
      end
    end

    class InternalMethodRewriter < Rewriter
      def on_send(node)
        teal_methods = @contract.class.teal_methods

        method_name = node.loc.selector.source.to_sym

        if teal_methods.keys.include? method_name
          param_names = teal_methods[method_name].parameters.map(&:last)

          pre_string = StringIO.new
          param_names.each_with_index do |param, i|
            scratch_name = [method_name, param].map(&:to_s).join(': ')

            pre_string.puts "@scratch.store('#{scratch_name}', #{node.children[i + 2].loc.expression.source})"
          end

          replace node.source_range, "#{pre_string.string};#{method_name}"
        end

        super
      end
    end

    class MethodRewriter < Rewriter
      def on_def(node)
        replace node.source_range, node.body.source
        super
      end

      def on_block(node)
        replace node.source_range, node.body.source
      end

      def on_send(node)
        remove node.loc.selector if node.loc.selector.source == 'subroutine' || node.loc.selector.source == 'teal'

        super
      end
    end

    class AssignRewriter < Rewriter
      def on_send(node)
        @last_src_map_node = node if node.source[/src_map/]
        super
      end

      def on_lvasgn(node)
        wrap(node.children[1].source_range, "-> { #{@last_src_map_node.source}; ", ' }')
        remove @last_src_map_node.source_range
        super
      end

      def on_lvar(node)
        insert_after(node.loc.name, '.call')
        super
      end

      def on_ivasgn(node)
        wrap(node.children[1].source_range, "-> { #{@last_src_map_node.source}; ", ' }')
        remove @last_src_map_node.source_range
        super
      end

      def on_ivar(node)
        insert_after(node.loc.name, '.call')
        super
      end

      def on_gvasgn(node)
        unless RuboCop::Cop::Style::GlobalVars::BUILT_IN_VARS.include? node.loc.name.source.to_sym
          var_name = node.loc.name.source[1..]
          replace(node.loc.name, "@scratch[:#{var_name}]")
        end

        super
      end

      def on_gvar(node)
        unless RuboCop::Cop::Style::GlobalVars::BUILT_IN_VARS.include? node.loc.name.source.to_sym
          var_name = node.loc.name.source[1..]
          replace(node.loc.name, "@scratch[:#{var_name}]")
        end

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
        @skips = []
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

        replace(op_loc, '.boolean_or')
        super
      end

      def on_return(node)
        replace node.loc.keyword, 'abi_return'

        super
      end

      OPCODE_METHODS = TEALrb::Opcodes::TEALOpcodes.instance_methods.freeze
      OPCODE_INSTANCE_METHODS = TEALrb::Opcodes::BINARY_OPCODE_METHOD_MAPPING.merge(TEALrb::Opcodes::UNARY_OPCODE_METHOD_MAPPING)

      def on_send(node)
        meth_name = node.children[1]

        if OPCODE_METHODS.include? meth_name
          if meth_name[/(byte|int)cblock/]
            @skips += node.children[2..]
          else
            params = TEALrb::Opcodes::TEALOpcodes.instance_method(meth_name).parameters
            req_params = params.count { |param| param[0] == :req }
            @skips += node.children[2..(1 + req_params.size)] unless req_params.zero?
          end
        elsif OPCODE_INSTANCE_METHODS.keys.include? meth_name
          replace node.loc.selector, ".#{OPCODE_INSTANCE_METHODS[meth_name]}"
        elsif %i[comment placeholder rb].include?(meth_name)
          @skips << node.children[2]
        end

        super
      end

      def on_int(node)
        if @skips.include? node
          @skips.delete(node)
        else
          wrap(node.source_range, 'int(', ')')
        end

        super
      end

      def on_str(node)
        if @skips.include? node
          @skips.delete(node)
        else
          wrap(node.source_range, 'byte(', ')')
        end

        super
      end

      def on_sym(node)
        if @skips.include? node
          @skips.delete(node)
        elsif node.source_range.source[/^:/]
          wrap(node.source_range, 'label(', ')')
        end

        super
      end
    end

    class InlineIfRewriter < Rewriter
      def on_if(node)
        unless node.loc.respond_to? :else
          conditional = node.children[0].source

          if_blk = if node.keyword == 'unless'
                     node.children[2].source
                     conditional = "!(#{conditional})"
                   else
                     node.children[1].source
                   end

          replace(node.loc.expression, "if(#{conditional});#{if_blk};end")
        end

        super
      end
    end

    class IfRewriter < Rewriter
      def on_if(node)
        case node.loc.keyword.source
        when 'if'
          replace(node.loc.keyword, 'teal_if((')
        when 'unless'
          replace(node.loc.keyword, 'teal_if(!(')
        when 'elsif'
          replace(node.loc.keyword, 'end.elsif((')
        end

        cond_expr = node.children.first.source_range
        replace(cond_expr, "#{cond_expr.source} )) do")

        replace(node.loc.else, 'end.else do') if node.loc.else && node.loc.else.source == 'else'
        super
      end
    end

    class WhileRewriter < Rewriter
      class << self
        attr_accessor :while_count
      end

      def initialize(*args)
        self.class.while_count = {}
        self.class.while_count[Thread.current] ||= 0
        super
      end

      def while_count
        self.class.while_count[Thread.current]
      end

      def on_while(node)
        cond_node = node.children.first
        replace(node.loc.keyword, ":while#{while_count};#{cond_node.source};bz :end_while#{while_count}")
        replace(node.loc.begin, '') if node.loc.begin
        replace(node.loc.end, "b :while#{while_count};:end_while#{while_count}")
        replace(cond_node.loc.expression, '')
        super
      end
    end
  end
end
