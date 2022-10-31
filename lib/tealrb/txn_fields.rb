module TEALrb
  module TxnFields
    def txnfield_opcode(*args)
      raise NotImplementedError
    end

    # @return [[]byte] 32 byte address (v1)
    def sender(*args)
      @contract.account txnfield_opcode('Sender', *args)
    end

    # @return [uint64] microalgos (v1)
    def fee(*args)
      txnfield_opcode('Fee', *args)
    end

    # @return [uint64] round number (v1)
    def first_valid(*args)
      txnfield_opcode('FirstValid', *args)
    end

    # @return [uint64] Causes program to fail; reserved for future use (v1)
    def first_valid_time(*args)
      txnfield_opcode('FirstValidTime', *args)
    end

    # @return [uint64] round number (v1)
    def last_valid(*args)
      txnfield_opcode('LastValid', *args)
    end

    # @return [[]byte] Any data up to 1024 bytes (v1)
    def note(*args)
      txnfield_opcode('Note', *args)
    end

    # @return [[]byte] 32 byte lease value (v1)
    def lease(*args)
      txnfield_opcode('Lease', *args)
    end

    # @return [[]byte] 32 byte address (v1)
    def receiver(*args)
      @contract.account txnfield_opcode('Receiver', *args)
    end

    # @return [uint64] microalgos (v1)
    def amount(*args)
      txnfield_opcode('Amount', *args)
    end

    # @return [[]byte] 32 byte address (v1)
    def close_remainder_to(*args)
      @contract.account txnfield_opcode('CloseRemainderTo', *args)
    end

    # @return [[]byte] 32 byte address (v1)
    def vote_pk(*args)
      txnfield_opcode('VotePK', *args)
    end

    # @return [[]byte] 32 byte address (v1)
    def selection_pk(*args)
      txnfield_opcode('SelectionPK', *args)
    end

    # @return [uint64] The first round that the participation key is valid. (v1)
    def vote_first(*args)
      txnfield_opcode('VoteFirst', *args)
    end

    # @return [uint64] The last round that the participation key is valid. (v1)
    def vote_last(*args)
      txnfield_opcode('VoteLast', *args)
    end

    # @return [uint64] Dilution for the 2-level participation key (v1)
    def vote_key_dilution(*args)
      txnfield_opcode('VoteKeyDilution', *args)
    end

    # @return [[]byte] Transaction type as bytes (v1)
    def type(*args)
      txnfield_opcode('Type', *args)
    end

    # @return [uint64] See table below (v1)
    def type_enum(*args)
      txnfield_opcode('TypeEnum', *args)
    end

    # @return [uint64] Asset ID (v1)
    def xfer_asset(*args)
      @contract.asset txnfield_opcode('XferAsset', *args)
    end

    # @return [uint64] value in Asset's units (v1)
    def asset_amount(*args)
      txnfield_opcode('AssetAmount', *args)
    end

    # @return [[]byte] 32 byte address. Causes clawback of all value of asset from AssetSender if
    #   Sender is the Clawback address of the asset. (v1)
    def asset_sender(*args)
      @contract.account txnfield_opcode('AssetSender', *args)
    end

    # @return [[]byte] 32 byte address (v1)
    def asset_receiver(*args)
      @contract.account txnfield_opcode('AssetReceiver', *args)
    end

    # @return [[]byte] 32 byte address (v1)
    def asset_close_to(*args)
      @contract.account txnfield_opcode('AssetCloseTo', *args)
    end

    # @return [uint64] Position of this transaction within an atomic transaction group.
    #   A stand-alone transaction is implicitly element 0 in a group of 1 (v1)
    def group_index(*args)
      txnfield_opcode('GroupIndex', *args)
    end

    # @return [[]byte] The computed ID for this transaction. 32 bytes. (v1)
    def tx_id(*args)
      txnfield_opcode('TxID', *args)
    end

    # @return [uint64] ApplicationID from ApplicationCall transaction (v2)
    def application_id(*args)
      @contract.app txnfield_opcode('ApplicationID', *args)
    end

    # @return [uint64] ApplicationCall transaction on completion action (v2)
    def on_completion(*args)
      txnfield_opcode('OnCompletion', *args)
    end

    # @return [[]byte] Arguments passed to the application in the ApplicationCall transaction (v2)
    def application_args(*args)
      txnfield_opcode('ApplicationArgs', *args)
    end

    # @return [uint64] Number of ApplicationArgs (v2)
    def num_app_args(*args)
      txnfield_opcode('NumAppArgs', *args)
    end

    # @return [[]byte] Accounts listed in the ApplicationCall transaction (v2)
    def accounts(*args)
      txnfield_opcode('Accounts', *args)
    end

    # @return [uint64] Number of Accounts (v2)
    def num_accounts(*args)
      txnfield_opcode('NumAccounts', *args)
    end

    # @return [[]byte] Approval program (v2)
    def approval_program(*args)
      txnfield_opcode('ApprovalProgram', *args)
    end

    # @return [[]byte] Clear state program (v2)
    def clear_state_program(*args)
      txnfield_opcode('ClearStateProgram', *args)
    end

    # @return [[]byte] 32 byte Sender's new AuthAddr (v2)
    def rekey_to(*args)
      @contract.account txnfield_opcode('RekeyTo', *args)
    end

    # @return [uint64] Asset ID in asset config transaction (v2)
    def config_asset(*args)
      @contract.asset txnfield_opcode('ConfigAsset', *args)
    end

    # @return [uint64] Total number of units of this asset created (v2)
    def config_asset_total(*args)
      txnfield_opcode('ConfigAssetTotal', *args)
    end

    # @return [uint64] Number of digits to display after the decimal place when displaying the asset (v2)
    def config_asset_decimals(*args)
      txnfield_opcode('ConfigAssetDecimals', *args)
    end

    # @return [uint64] Whether the asset's slots are frozen by default or not, 0 or 1 (v2)
    def config_asset_default_frozen(*args)
      txnfield_opcode('ConfigAssetDefaultFrozen', *args)
    end

    # @return [[]byte] Unit name of the asset (v2)
    def config_asset_unit_name(*args)
      txnfield_opcode('ConfigAssetUnitName', *args)
    end

    # @return [[]byte] The asset name (v2)
    def config_asset_name(*args)
      txnfield_opcode('ConfigAssetName', *args)
    end

    # @return [[]byte] URL (v2)
    def config_asset_url(*args)
      txnfield_opcode('ConfigAssetURL', *args)
    end

    # @return [[]byte] 32 byte commitment to some unspecified asset metadata (v2)
    def config_asset_metadata_hash(*args)
      txnfield_opcode('ConfigAssetMetadataHash', *args)
    end

    # @return [[]byte] 32 byte address (v2)
    def config_asset_manager(*args)
      @contract.account txnfield_opcode('ConfigAssetManager', *args)
    end

    # @return [[]byte] 32 byte address (v2)
    def config_asset_reserve(*args)
      @contract.account txnfield_opcode('ConfigAssetReserve', *args)
    end

    # @return [[]byte] 32 byte address (v2)
    def config_asset_freeze(*args)
      @contract.account txnfield_opcode('ConfigAssetFreeze', *args)
    end

    # @return [[]byte] 32 byte address (v2)
    def config_asset_clawback(*args)
      @contract.account txnfield_opcode('ConfigAssetClawback', *args)
    end

    # @return [uint64] Asset ID being frozen or un-frozen (v2)
    def freeze_asset(*args)
      @contract.asset txnfield_opcode('FreezeAsset', *args)
    end

    # @return [[]byte] 32 byte address of the account whose asset slot is being frozen or un-frozen (v2)
    def freeze_asset_account(*args)
      @contract.account txnfield_opcode('FreezeAssetAccount', *args)
    end

    # @return [uint64] The new frozen value, 0 or 1 (v2)
    def freeze_asset_frozen(*args)
      txnfield_opcode('FreezeAssetFrozen', *args)
    end

    # @return [uint64] Foreign Assets listed in the ApplicationCall transaction (v3)
    def assets(*args)
      txnfield_opcode('Assets', *args)
    end

    # @return [uint64] Number of Assets (v3)
    def num_assets(*args)
      txnfield_opcode('NumAssets', *args)
    end

    # @return [uint64] Foreign Apps listed in the ApplicationCall transaction (v3)
    def applications(*args)
      txnfield_opcode('Applications', *args)
    end

    # @return [uint64] Number of Applications (v3)
    def num_applications(*args)
      txnfield_opcode('NumApplications', *args)
    end

    # @return [uint64] Number of global state integers in ApplicationCall (v3)
    def global_num_uint(*args)
      txnfield_opcode('GlobalNumUint', *args)
    end

    # @return [uint64] Number of global state byteslices in ApplicationCall (v3)
    def global_num_byte_slice(*args)
      txnfield_opcode('GlobalNumByteSlice', *args)
    end

    # @return [uint64] Number of local state integers in ApplicationCall (v3)
    def local_num_uint(*args)
      txnfield_opcode('LocalNumUint', *args)
    end

    # @return [uint64] Number of local state byteslices in ApplicationCall (v3)
    def local_num_byte_slice(*args)
      txnfield_opcode('LocalNumByteSlice', *args)
    end

    # @return [uint64] Number of additional pages for each of the application's approval and clear state programs.
    #   An ExtraProgramPages of 1 means 2048 more total bytes, or 1024 for each program. (v4)
    def extra_program_pages(*args)
      txnfield_opcode('ExtraProgramPages', *args)
    end

    # @return [uint64] Marks an account nonparticipating for rewards (v5)
    def nonparticipation(*args)
      txnfield_opcode('Nonparticipation', *args)
    end

    # @return [[]byte] Log messages emitted by an application call (only with itxn in v5). Application mode only (v5)
    def logs(*args)
      txnfield_opcode('Logs', *args)
    end

    # @return [uint64] Number of Logs (only with itxn in v5). Application mode only (v5)
    def num_logs(*args)
      txnfield_opcode('NumLogs', *args)
    end

    # @return [uint64] Asset ID allocated by the creation of an ASA (only with itxn in v5). Application mode only (v5)
    def created_asset_id(*args)
      @contract.asset txnfield_opcode('CreatedAssetID', *args)
    end

    # @return [uint64] ApplicationID allocated by the creation of an application (only with itxn in v5).
    #   Application mode only (v5)
    def created_application_id(*args)
      @contract.app txnfield_opcode('CreatedApplicationID', *args)
    end

    # @return [[]byte] The last message emitted. Empty bytes if none were emitted. Application mode only (v6)
    def last_log(*args)
      txnfield_opcode('LastLog', *args)
    end

    # @return [[]byte] 64 byte state proof public key commitment (v6)
    def state_proof_pk(*args)
      txnfield_opcode('StateProofPK', *args)
    end
  end
end
