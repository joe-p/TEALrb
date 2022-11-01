# frozen_string_literal: true

module TEALrb
  class GroupTxn < OpcodeType
    include TxnFields

    def txnfield_opcode(field, *_args)
      @contract.gtxns field
    end

    def [](index)
      if index.is_a? Integer
        Gtxn.new(@contract, index)
      else
        self
      end
    end
  end

  class Gtxn < GroupTxn
    def initialize(contract, index)
      @index = index
      super(contract)
    end

    def txnfield_opcode(field, *_args)
      @contract.gtxn @index, field
    end
  end

  class Pay < GroupTxn; end

  class Keyreg < GroupTxn; end

  class Keyreg < GroupTxn; end

  class Axfer < GroupTxn; end

  class Afrz < GroupTxn; end

  class Appl < GroupTxn; end
end
