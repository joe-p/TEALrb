module TEALrb
  module Expressions
    module Types
      class Int < Expression
        def initialize(integer)
          @teal = TEAL.new ["int #{integer}"]
        end
      end

      def int(integer)
        Int.new integer
      end

      class Byte < Expression
        def initialize(string)
          @teal = TEAL.new ["byte \"#{string}\""]
        end
      end

      def byte(string)
        Byte.new string
      end

      class Btoi < Expression
        def initialize(bytes = nil)
          @teal = TEAL.new [bytes.teal, 'btoi']
        end
      end

      def btoi(bytes = nil)
        Btoi.new bytes
      end

      class Itob < Expression
        def initialize(bytes = nil)
          @teal = TEAL.new [bytes.teal, 'itob']
        end
      end

      def itob(bytes = nil)
        Itob.new bytes
      end
    end
  end
end
