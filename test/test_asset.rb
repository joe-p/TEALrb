# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'
class AssetTests < Minitest::Test
  include TestMethods

  {
    asset_total: 'AssetTotal',
    asset_decimals: 'AssetDecimals',
    asset_default_frozen: 'AssetDefaultFrozen',
    asset_unit_name: 'AssetUnitName',
    asset_name: 'AssetName',
    asset_url: 'AssetURL',
    asset_metadata_hash: 'AssetMetadataHash',
    asset_manager: 'AssetManager',
    asset_reserve: 'AssetReserve',
    asset_freeze: 'AssetFreeze',
    asset_clawback: 'AssetClawback',
    asset_creator: 'AssetCreator'
  }.each do |meth, enum|
    define_method("test_asset_#{meth}") do
      compile_test_last("Asset.#{meth}", "asset_params_get #{enum}")
    end
  end
end
