# frozen_string_literal: true

module TEALrb
  module Opcodes
    module Transaction
      def txn(field)
        TEAL.new ["txn #{field}"]
      end

      module TxnFields
        include Transaction

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
        extend TxnFields

        def self.opcode(field)
          txn field
        end
      end

      module Gtxn
        extend TxnFields

        def self.opcode(field, index)
          gtxn index, field
        end

        def self.[](index)
          GroupTransaction.new(index)
        end
      end

      def gtxn(index, field)
        TEAL.new ["gtxn #{index} #{field}"]
      end

      def gtxnsas(field, index = nil, transaction_index = nil)
        TEAL.new [index.teal, transaction_index.teal, "gtxnsas #{field}"]
      end

      def gtxna(transaction_index, field, index)
        TEAL.new ["gtxna #{transaction_index} #{field} #{index}"]
      end

      def gtxnsa(field, index, transaction_index = nil)
        TEAL.new [transaction_index.teal, "gtxna #{field} #{index}"]
      end

      def gitxn(transaction_index, field)
        TEAL.new ["gitxn #{transaction_index} #{field}"]
      end

      def gitxna(transaction_index, field, index)
        TEAL.new ["gitxna #{transaction_index} #{field} #{index}"]
      end

      def gitxnas(transaction_index, field, index = nil)
        TEAL.new [index.teal, "gitxnas #{transaction_index} #{field}"]
      end

      class GroupTransaction
        include TxnFields

        def initialize(index)
          @index = index
        end

        def opcode(field)
          gtxn @index, field
        end
      end

      module Txna
        extend TxnFields

        def self.opcode(field, index)
          txna field, index
        end
      end

      def txna(field, index)
        TEAL.new ["txna #{field} #{index}"]
      end

      def itxn_begin
        TEAL.new ['itxn_begin']
      end

      def itxn_field(field, value = nil)
        TEAL.new [value.teal, "itxn_field #{field}"]
      end

      def itxn_submit
        TEAL.new ['itxn_submit']
      end

      def itxna(field, index)
        TEAL.new ["itxna #{field} #{index}"]
      end
    end
  end
end
