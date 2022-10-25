# frozen_string_literal: true

class TestContract < TEALrb::Contract
  @src_map = false
end

module TestMethods
  def compile_test_last(input, teal, count = 1)
    contract = TestContract.new
    contract.compile_string input

    if count == 1
      assert_equal(teal, contract.teal.last)
    else
      assert_equal(teal, contract.teal[-count..])
    end
  end

  def compile_test(input, teal)
    contract = TestContract.new
    contract.compile_string input

    assert_equal(teal, contract.teal[1..])
  end
end

TXN_FIELD_HASH = {
  sender: 'Sender',
  fee: 'Fee',
  first_valid: 'FirstValid',
  first_valid_time: 'FirstValidTime',
  last_valid: 'LastValid',
  note: 'Note',
  lease: 'Lease',
  receiver: 'Receiver',
  amount: 'Amount',
  close_remainder_to: 'CloseRemainderTo',
  vote_pk: 'VotePK',
  selection_pk: 'SelectionPK',
  vote_first: 'VoteFirst',
  vote_last: 'VoteLast',
  vote_key_dilution: 'VoteKeyDilution',
  type: 'Type',
  type_enum: 'TypeEnum',
  xfer_asset: 'XferAsset',
  asset_amount: 'AssetAmount',
  asset_sender: 'AssetSender',
  asset_receiver: 'AssetReceiver',
  asset_close_to: 'AssetCloseTo',
  group_index: 'GroupIndex',
  tx_id: 'TxID',
  application_id: 'ApplicationID',
  on_completion: 'OnCompletion',
  application_args: 'ApplicationArgs',
  num_app_args: 'NumAppArgs',
  accounts: 'Accounts',
  num_accounts: 'NumAccounts',
  approval_program: 'ApprovalProgram',
  clear_state_program: 'ClearStateProgram',
  rekey_to: 'RekeyTo',
  config_asset: 'ConfigAsset',
  config_asset_total: 'ConfigAssetTotal',
  config_asset_decimals: 'ConfigAssetDecimals',
  config_asset_default_frozen: 'ConfigAssetDefaultFrozen',
  config_asset_unit_name: 'ConfigAssetUnitName',
  config_asset_name: 'ConfigAssetName',
  config_asset_url: 'ConfigAssetURL',
  config_asset_metadata_hash: 'ConfigAssetMetadataHash',
  config_asset_manager: 'ConfigAssetManager',
  config_asset_reserve: 'ConfigAssetReserve',
  config_asset_freeze: 'ConfigAssetFreeze',
  config_asset_clawback: 'ConfigAssetClawback',
  freeze_asset: 'FreezeAsset',
  freeze_asset_account: 'FreezeAssetAccount',
  freeze_asset_frozen: 'FreezeAssetFrozen',
  assets: 'Assets',
  num_assets: 'NumAssets',
  applications: 'Applications',
  num_applications: 'NumApplications',
  global_num_uint: 'GlobalNumUint',
  global_num_byte_slice: 'GlobalNumByteSlice',
  local_num_uint: 'LocalNumUint',
  local_num_byte_slice: 'LocalNumByteSlice',
  extra_program_pages: 'ExtraProgramPages',
  nonparticipation: 'Nonparticipation',
  logs: 'Logs',
  num_logs: 'NumLogs',
  created_asset_id: 'CreatedAssetID',
  created_application_id: 'CreatedApplicationID',
  last_log: 'LastLog',
  state_proof_pk: 'StateProofPK'
}.freeze
