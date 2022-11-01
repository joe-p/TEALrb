# frozen_string_literal: true

module TEALrb
  class ThisTxn < OpcodeType
    include TxnFields

    private

    def txnfield_opcode(field, *_args)
      @contract.txn field
    end
  end
end
