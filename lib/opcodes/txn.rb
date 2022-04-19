module TEALrb
  module Opcodes
    module Transaction
      def txn(field)
        TEAL.new ["txn #{field}"]
      end

      module Txn
        extend Transaction
        def self.application_id
          txn 'ApplicationID'
        end

        def self.sender
          txn 'Sender'
        end
      end

      module Gtxn
        extend Transaction

        def self.application_id(index)
          gtxn index, 'ApplicationID'
        end

        def self.sender(index)
          gtxn index, 'Sender'
        end

        def self.receiver(index)
          gtxn index, 'Receiver'
        end

        def self.amount(index)
          gtxn index, 'Amount'
        end

        def self.[](index)
          GroupTransaction.new(index)
        end
      end

      def gtxn(index, field)
        TEAL.new ["gtxn #{index} #{field}"]
      end

      class GroupTransaction
        def initialize(index)
          @index = index
        end

        GTXN_METHODS = %i[
          sender
          receiver
          application_id
          amount
        ]

        GTXN_METHODS.each do |meth|
          define_method meth do
            Gtxn.send(meth, @index)
          end
        end
      end

      module Txna
        extend Transaction

        def self.application_args(index)
          txna 'ApplicationArgs', index
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
    end
  end
end
