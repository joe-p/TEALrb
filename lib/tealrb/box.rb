module TEALrb
  class Box
    def initialize(contract)
      @contract = contract
    end

    def [](key)
      @contract.box_value key
    end

    def []=(key, value)
      @contract.box_put key, value
    end
  end
end
