# frozen_string_literal: true

module TEALrb
  module Opcodes
    module Types
      def pushint(integer)
        TEAL.new ["pushint #{integer}"]
      end

      def pushbytes(string)
        TEAL.new ["pushbytes \"#{string}\""]
      end

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
