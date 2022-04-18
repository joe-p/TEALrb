module TEALrb
  module Opcodes
    module Byte
      def concat(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'concat']
      end
    end
  end
end
