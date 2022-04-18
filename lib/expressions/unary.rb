module TEALrb
  module Opcodes
    module Unary
      def not(expr = nil)
        TEAL.new [expr.teal, '!']
      end
    end
  end
end
