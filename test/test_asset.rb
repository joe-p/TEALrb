# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'

class AssetTests < Minitest::Test
  include TestMethods

  {
    total: 'AssetTotal',
    decimals: 'AssetDecimals',
    default_frozen: 'AssetDefaultFrozen',
    unit_name: 'AssetUnitName',
    name: 'AssetName',
    url: 'AssetURL',
    metadata_hash: 'AssetMetadataHash',
    manager: 'AssetManager',
    reserve: 'AssetReserve',
    freeze: 'AssetFreeze',
    clawback: 'AssetClawback',
    creator: 'AssetCreator'
  }.each do |meth, enum|
    define_method("test_#{meth}") do
      compile_test_last("assets[0].#{meth}", ['txna Assets 0', "asset_params_get #{enum}", 'pop'], 3)
    end
  end

  {
    total?: 'AssetTotal',
    decimals?: 'AssetDecimals',
    default_frozen?: 'AssetDefaultFrozen',
    unit_name?: 'AssetUnitName',
    name?: 'AssetName',
    url?: 'AssetURL',
    metadata_hash?: 'AssetMetadataHash',
    manager?: 'AssetManager',
    reserve?: 'AssetReserve',
    freeze?: 'AssetFreeze',
    clawback?: 'AssetClawback',
    creator?: 'AssetCreator'
  }.each do |meth, enum|
    define_method("test_#{meth}") do
      compile_test_last("assets[0].#{meth}", ['txna Assets 0', "asset_params_get #{enum}", 'swap', 'pop'], 4)
    end
  end
end
