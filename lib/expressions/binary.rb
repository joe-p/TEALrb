module TEALrb
  module Expressions
    module Binary
      class Add < Expression
        def initialize(a, b)
          @teal = TEAL.new [a.teal, b.teal, '+']
        end
      end

      def add(a = nil, b = nil)
        Add.new a, b
      end

      class Subtract < Expression
        def initialize(a, b)
          @teal = TEAL.new [a.teal, b.teal, '-']
        end
      end

      def subtract(a = nil, b = nil)
        Subtract.new a, b
      end

      class Divide < Expression
        def initialize(a, b)
          @teal = TEAL.new [a.teal, b.teal, '/']
        end
      end

      def divide(a = nil, b = nil)
        Divide.new a, b
      end

      class Multiply < Expression
        def initialize(a, b)
          @teal = TEAL.new [a.teal, b.teal, '*']
        end
      end

      def multiply(a = nil, b = nil)
        Multiply.new a, b
      end

      class LessThan < Expression
        def initialize(a, b)
          @teal = TEAL.new [a.teal, b.teal, '<']
        end
      end

      def less(a = nil, b = nil)
        LessThan.new a, b
      end

      class GreaterThan < Expression
        def initialize(a, b)
          @teal = TEAL.new [a.teal, b.teal, '>']
        end
      end

      def greater(a = nil, b = nil)
        GreaterThan.new a, b
      end

      class LessThanOrEqual < Expression
        def initialize(a, b)
          @teal = TEAL.new [a.teal, b.teal, '<=']
        end
      end

      def less_eq(a = nil, b = nil)
        LessThanOrEqual.new a, b
      end

      class GreaterThanOrEqual < Expression
        def initialize(a, b)
          @teal = TEAL.new [a.teal, b.teal, '>=']
        end
      end

      def greater_eq(a = nil, b = nil)
        GreaterThanOrEqual.new a, b
      end

      class Equal < Expression
        def initialize(a, b)
          @teal = TEAL.new [a.teal, b.teal, '==']
        end
      end

      def equal(a = nil, b = nil)
        Equal.new a, b
      end

      class NotEqual < Expression
        def initialize(a, b)
          @teal = TEAL.new [a.teal, b.teal, '!=']
        end
      end

      def not_equal(a = nil, b = nil)
        NotEqual.new a, b
      end

      class BitwiseAnd < Expression
        def initialize(a, b)
          @teal = TEAL.new [a.teal, b.teal, '&']
        end
      end

      def bitwise_and(a = nil, b = nil)
        BitwiseAnd.new a, b
      end
    end
  end
end
