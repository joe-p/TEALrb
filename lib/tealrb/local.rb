# frozen_string_literal: true

module TEALrb
  class LocalAccount
    def initialize(contract)
      @contract = contract
    end

    def [](_key)
      @contract.app_local_get
    end

    def []=(_key, _value)
      @contract.app_local_put
    end
  end

  class Local
    def initialize(contract)
      @contract = contract
    end

    def [](_account)
      LocalAccount.new @contract
    end
  end
end
