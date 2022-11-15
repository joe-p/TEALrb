# frozen_string_literal: true

module TEALrb
  module Enums
    class TxnType
      def initialize(contract)
        @contract = contract
      end

      def unknown
        txn_type_int 'unknown'
      end

      def pay
        txn_type_int 'pay'
      end

      def key_registration
        txn_type_int 'keyreg'
      end

      def asset_config
        txn_type_int 'acfg'
      end

      def asset_transfer
        txn_type_int 'axfer'
      end

      def asset_freeze
        txn_type_int 'afrz'
      end

      def application_call
        txn_type_int 'appl'
      end

      private

      def txn_type_int(type)
        @contract.teal << "int #{type}"
      end
    end
  end
end
