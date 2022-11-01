module TEALrb
  class Account < OpcodeType
    def initialize(contract)
      @field = 'Accounts'
      super
    end

    def asset_balance?(_asa_id = nil)
      @contract.asset_holding_exists? 'AssetBalance'
    end

    def asset_balance(_asa_id = nil)
      @contract.asset_holding_value 'AssetBalance'
    end

    def asset_frozen?(_asa_id = nil)
      @contract.asset_frozen_exists? 'AssetFrozen'
    end

    def asset_frozen_value(_asa_id = nil)
      @contract.asset_frozen_value 'AssetFrozen'
    end

    def min_balance
      @contract.acct_param_value 'AcctMinBalance'
    end

    def balance
      @contract.acct_param_value 'AcctBalance'
    end

    def auth_addr
      @contract.acct_param_value 'AcctAuthAddr'
    end

    def balance?
      @contract.acct_has_balance?
    end
  end
end
