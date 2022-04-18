module TEALrb
  module Expressions
    module Unary
      def not(expr = nil)
        TEAL.new [expr.teal, '!']
      end
    end
  end
end
