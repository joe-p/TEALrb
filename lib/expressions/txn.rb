module TEALrb
  module Expressions
    module Transaction
      class Txn < Expression
        def self.application_id
          new 'ApplicationID'
        end

        def self.sender
          new 'Sender'
        end

        def initialize(field)
          @teal = TEAL.new ["txn #{field}"]
        end
      end

      def txn(field)
        Txn.new(field)
      end

      class Gtxn < Expression
        def self.application_id(index)
          new index, 'ApplicationID'
        end

        def self.sender(index)
          new index, 'Sender'
        end

        def self.receiver(index)
          new index, 'Receiver'
        end

        def self.amount(index)
          new index, 'Amount'
        end

        def self.[](index)
          GroupTransaction.new(index)
        end

        def initialize(index, field)
          @teal = TEAL.new ["gtxn #{index} #{field}"]
        end
      end

      def gtxn(index, field)
        Gtxn.new(index, field)
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

      class Txna < Expression
        def self.application_args(index)
          new 'ApplicationArgs', index
        end

        def initialize(field, index)
          @teal = TEAL.new ["txna #{field} #{index}"]
        end
      end

      def txna(field)
        Txna.new(field)
      end

      class ItxnBegin < Expression
        def initialize
          @teal = TEAL.new ['itxn_begin']
        end
      end

      def itxn_begin
        ItxnBegin.new
      end

      class ItxnField < Expression
        def initialize(field, value = nil)
          @teal = TEAL.new [value.teal, "itxn_field #{field}"]
        end
      end

      def itxn_field(field, value = nil)
        ItxnField.new field, value
      end

      class ItxnSubmit < Expression
        def initialize
          @teal = TEAL.new ['itxn_submit']
        end
      end

      def itxn_submit
        ItxnSubmit.new
      end
    end
  end
end
