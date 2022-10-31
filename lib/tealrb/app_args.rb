module TEALrb
  class AppArgs
    def initialize(contract)
      @contract = contract
    end

    def [](_index)
      @contract.txnas 'ApplicationArgs'
    end
  end
end
