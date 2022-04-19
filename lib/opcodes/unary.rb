module TEALrb
  module Opcodes
    module Unary
      OPCODE_METHOD_MAPPING = {
        '!': 'not'
      }

      def not(expr = nil)
        TEAL.new [expr.teal, '!']
      end
    end
  end
end
