# frozen_string_literal: true

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

    def uints
      @contract.acct_param_value 'AcctTotalNumUint'
    end

    def bytes
      @contract.acct_param_value 'AcctTotalNumByteSlice'
    end

    def extra_pages
      @contract.acct_param_value 'AcctTotalExtraAppPages'
    end

    def apps_created
      @contract.acct_param_value 'AcctTotalAppsCreated'
    end

    def apps_opted_in
      @contract.acct_param_value 'AcctTotalAppsOptedIn'
    end

    def assets_created
      @contract.acct_param_value 'AcctTotalAssetsCreated'
    end

    def assets
      @contract.acct_param_value 'AcctTotalAssets'
    end

    def boxes
      @contract.acct_param_value 'AcctTotalBoxes'
    end

    def box_bytes
      @contract.acct_param_value 'AcctTotalBoxBytes'
    end
  end
end
