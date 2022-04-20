module TEALrb
  module Opcodes
    module TxnFields
      def application_id(*args)
        opcode('ApplicationID', *args)
      end

      def sender(*args)
        opcode('Sender', *args)
      end

      def receiver(*args)
        opcode('Receiver', *args)
      end

      def amount(*args)
        opcode('Amount', *args)
      end

      def application_args(*args)
        opcode('ApplicationArgs', *args)
      end
    end

    module Txn
      extend Opcodes
      extend TxnFields

      def self.opcode(field)
        txn field
      end
    end

    module Gtxn
      extend TxnFields
      extend Opcodes

      def self.opcode(field, index)
        gtxn index, field
      end

      def self.[](index)
        GroupTransaction.new(index)
      end
    end

    class GroupTransaction
      include TxnFields
      include Opcodes

      def initialize(index)
        @index = index
      end

      def opcode(field)
        gtxn @index, field
      end
    end

    module Txna
      extend Opcodes
      extend TxnFields

      def self.opcode(field, index)
        txna field, index
      end
    end

    module Global
      extend Opcodes

      def self.current_application_address
        global 'CurrentApplicationAddress'
      end

      def self.latest_timestamp
        global 'LatestTimestamp'
      end
    end
  end
end
