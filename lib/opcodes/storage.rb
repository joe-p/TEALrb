# frozen_string_literal: true

module TEALrb
  module Opcodes
    module Storage
      def store(index, value = nil)
        TEAL.new [value.teal, "store #{index}"]
      end

      def load(index = nil)
        TEAL.new ["load #{index}"]
      end

      def app_local_get(account = nil, key = nil)
        TEAL.new [account.teal, key.teal, 'app_local_get']
      end

      def app_global_get(key = nil)
        TEAL.new [key.teal, 'app_global_get']
      end

      def app_global_put(key = nil, value = nil)
        TEAL.new [key.teal, value.teal, 'app_global_put']
      end

      def gload(transaction_index, index)
        TEAL.new ["gload #{transaction_index} #{index}"]
      end

      def intcblock(*ints)
        TEAL.new ["intcblock #{ints.join(' ')}"]
      end

      def bytecblock(*bytes)
        TEAL.new ["bytecblock #{bytes.join(' ')}"]
      end
    end
  end
end
