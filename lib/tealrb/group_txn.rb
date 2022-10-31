module TEALrb
  class GroupTxn < OpcodeType
    include TxnFields

    def txnfield_opcode(field, *_args)
      @contract.gtxns field
    end

    def [](_index)
      self
    end
  end

  class Pay < GroupTxn; end

  class Keyreg < GroupTxn; end

  class Keyreg < GroupTxn; end

  class Axfer < GroupTxn; end

  class Afrz < GroupTxn; end

  class Appl < GroupTxn; end
end
