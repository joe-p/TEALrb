# rubocop:disable Lint/UnusedMethodArgument

module TEALrb
  module MaybeOps
    def asset_holding_value(field, account_index = nil, asset_id = nil)
      asset_holding_get field
      swap
      pop
    end

    def asset_holding_exists?(field, account_index = nil, asset_id = nil)
      asset_holding_get field
      pop
    end

    def app_param_exists?(field, app_id = nil)
      app_params_get field
      swap
      pop
    end

    def app_param_value(field, app_id = nil)
      app_params_get field
      pop
    end

    def asset_param_exists?(field, asset_id = nil)
      asset_params_get field
      swap
      pop
    end

    def asset_param_value(field, asset_id = nil)
      asset_params_get field
      pop
    end

    def acct_has_balance?(asset_id = nil)
      acct_params_get 'AcctBalance'
      swap
      pop
    end

    def acct_param_value(field, asset_id = nil)
      acct_params_get field
      pop
    end

    def app_local_ex_exists?(account = nil, applicaiton = nil, key = nil)
      app_local_get_ex
      swap
      pop
    end

    def app_local_ex_value(account = nil, applicaiton = nil, key = nil)
      app_local_get_ex
      pop
    end

    def app_global_ex_exists?(account = nil, applicaiton = nil, key = nil)
      app_global_get_ex
      swap
      pop
    end

    def app_global_ex_value(account = nil, applicaiton = nil, key = nil)
      app_global_get_ex
      pop
    end

    def box_value(name = nil)
      box_get
      pop
    end

    def box_exists?(name = nil)
      box_get
      swap
      pop
    end

    def box_len_value(name = nil)
      box_len
      pop
    end

    def box_len_exists?(name = nil)
      box_len
      swap
      pop
    end
  end
end
# rubocop:enable Lint/UnusedMethodArgument
