module TEALrb
  class Asset < OpcodeType
    def initialize(contract)
      @field = 'Assets'
      super
    end

    def total
      @contract.asset_param_value 'AssetTotal'
    end

    def decimals
      @contract.asset_param_value 'AssetDecimals'
    end

    def default_frozen
      @contract.asset_param_value 'AssetDefaultFrozen'
    end

    def name
      @contract.asset_param_value 'AssetName'
    end

    def unit_name
      @contract.asset_param_value 'AssetUnitName'
    end

    def url
      @contract.asset_param_value 'AssetURL'
    end

    def metadata_hash
      @contract.asset_param_value 'AssetMetadataHash'
    end

    def manager
      @contract.asset_param_value 'AssetManager'
    end

    def reserve
      @contract.asset_param_value 'AssetReserve'
    end

    def freeze
      @contract.asset_param_value 'AssetFreeze'
    end

    def clawback
      @contract.asset_param_value 'AssetClawback'
    end

    def creator
      @contract.asset_param_value 'AssetCreator'
    end

    def total?
      @contract.asset_param_exists? 'AssetTotal'
    end

    def decimals?
      @contract.asset_param_exists? 'AssetDecimals'
    end

    def default_frozen?
      @contract.asset_param_exists? 'AssetDefaultFrozen'
    end

    def name?
      @contract.asset_param_exists? 'AssetName'
    end

    def unit_name?
      @contract.asset_param_exists? 'AssetUnitName'
    end

    def url?
      @contract.asset_param_exists? 'AssetURL'
    end

    def metadata_hash?
      @contract.asset_param_exists? 'AssetMetadataHash'
    end

    def manager?
      @contract.asset_param_exists? 'AssetManager'
    end

    def reserve?
      @contract.asset_param_exists? 'AssetReserve'
    end

    def freeze?
      @contract.asset_param_exists? 'AssetFreeze'
    end

    def clawback?
      @contract.asset_param_exists? 'AssetClawback'
    end

    def creator?
      @contract.asset_param_exists? 'AssetCreator'
    end
  end
end
