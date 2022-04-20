# frozen_string_literal: true

module TEALrb
  module Opcodes
    module Byte
      def concat(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'concat']
      end

      def substring(start, exclusive_end, byte_array = nil)
        TEAL.new [byte_array.teal, "#{substring} #{start} #{exclusive_end}"]
      end

      def extract(start, length, byte_array = nil)
        TEAL.new [byte_array.teal, "extract #{start} #{length}"]
      end
    end
  end
end
