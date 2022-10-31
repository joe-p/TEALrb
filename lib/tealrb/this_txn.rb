module TEALrb
  class ThisTxn
    include TxnFields

    def initialize(contract)
      @contract = contract
    end

    private

    def txnfield_opcode(field, *_args)
      @contract.txn field
    end
  end
end
