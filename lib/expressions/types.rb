module TEALrb
  module Expressions
    module Types
      def int(integer)
        TEAL.new ["int #{integer}"]
      end

      def byte(string)
        TEAL.new ["byte \"#{string}\""]
      end

      def btoi(bytes = nil)
        TEAL.new [bytes.teal, 'btoi']
      end

      def itob(bytes = nil)
        TEAL.new [bytes.teal, 'itob']
      end
    end
  end
end
