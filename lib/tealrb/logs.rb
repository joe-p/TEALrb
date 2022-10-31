module TEALrb
  class Logs
    def initialize(contract)
      @contract = contract
    end

    def [](_index)
      @contract.txnas 'Logs'
    end
  end
end
