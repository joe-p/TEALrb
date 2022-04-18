module TEALrb
  module Expressions
    module Byte
      def concat(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'concat']
      end
    end
  end
end
