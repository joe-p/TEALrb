module TEALrb
  module Opcodes
    module Binary
      def add(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '+']
      end

      def subtract(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '-']
      end

      def divide(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '/']
      end

      def multiply(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '*']
      end

      def less(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '<']
      end

      def greater(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '>']
      end

      def less_eq(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '<=']
      end

      def greater_eq(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '>=']
      end

      def equal(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '==']
      end

      def not_equal(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '!=']
      end

      def bitwise_and(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '&']
      end
    end
  end
end
