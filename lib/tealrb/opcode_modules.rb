# frozen_string_literal: true

module TEALrb
  module ExtendedOpcodes
    extend Opcodes
  end

  module Opcodes
    module TxnFields
      # @return [[]byte] 32 byte address (v1)
      def sender(*args)
        opcode('Sender', *args)
      end

      # @return [uint64] microalgos (v1)
      def fee(*args)
        opcode('Fee', *args)
      end

      # @return [uint64] round number (v1)
      def first_valid(*args)
        opcode('FirstValid', *args)
      end

      # @return [uint64] Causes program to fail; reserved for future use (v1)
      def first_valid_time(*args)
        opcode('FirstValidTime', *args)
      end

      # @return [uint64] round number (v1)
      def last_valid(*args)
        opcode('LastValid', *args)
      end

      # @return [[]byte] Any data up to 1024 bytes (v1)
      def note(*args)
        opcode('Note', *args)
      end

      # @return [[]byte] 32 byte lease value (v1)
      def lease(*args)
        opcode('Lease', *args)
      end

      # @return [[]byte] 32 byte address (v1)
      def receiver(*args)
        opcode('Receiver', *args)
      end

      # @return [uint64] microalgos (v1)
      def amount(*args)
        opcode('Amount', *args)
      end

      # @return [[]byte] 32 byte address (v1)
      def close_remainder_to(*args)
        opcode('CloseRemainderTo', *args)
      end

      # @return [[]byte] 32 byte address (v1)
      def vote_pk(*args)
        opcode('VotePK', *args)
      end

      # @return [[]byte] 32 byte address (v1)
      def selection_pk(*args)
        opcode('SelectionPK', *args)
      end

      # @return [uint64] The first round that the participation key is valid. (v1)
      def vote_first(*args)
        opcode('VoteFirst', *args)
      end

      # @return [uint64] The last round that the participation key is valid. (v1)
      def vote_last(*args)
        opcode('VoteLast', *args)
      end

      # @return [uint64] Dilution for the 2-level participation key (v1)
      def vote_key_dilution(*args)
        opcode('VoteKeyDilution', *args)
      end

      # @return [[]byte] Transaction type as bytes (v1)
      def type(*args)
        opcode('Type', *args)
      end

      # @return [uint64] See table below (v1)
      def type_enum(*args)
        opcode('TypeEnum', *args)
      end

      # @return [uint64] Asset ID (v1)
      def xfer_asset(*args)
        opcode('XferAsset', *args)
      end

      # @return [uint64] value in Asset's units (v1)
      def asset_amount(*args)
        opcode('AssetAmount', *args)
      end

      # @return [[]byte] 32 byte address. Causes clawback of all value of asset from AssetSender if Sender is the Clawback address of the asset. (v1)
      def asset_sender(*args)
        opcode('AssetSender', *args)
      end

      # @return [[]byte] 32 byte address (v1)
      def asset_receiver(*args)
        opcode('AssetReceiver', *args)
      end

      # @return [[]byte] 32 byte address (v1)
      def asset_close_to(*args)
        opcode('AssetCloseTo', *args)
      end

      # @return [uint64] Position of this transaction within an atomic transaction group. A stand-alone transaction is implicitly element 0 in a group of 1 (v1)
      def group_index(*args)
        opcode('GroupIndex', *args)
      end

      # @return [[]byte] The computed ID for this transaction. 32 bytes. (v1)
      def tx_id(*args)
        opcode('TxID', *args)
      end

      # @return [uint64] ApplicationID from ApplicationCall transaction (v2)
      def application_id(*args)
        opcode('ApplicationID', *args)
      end

      # @return [uint64] ApplicationCall transaction on completion action (v2)
      def on_completion(*args)
        opcode('OnCompletion', *args)
      end

      # @return [[]byte] Arguments passed to the application in the ApplicationCall transaction (v2)
      def application_args(*args)
        opcode('ApplicationArgs', *args)
      end

      # @return [uint64] Number of ApplicationArgs (v2)
      def num_app_args(*args)
        opcode('NumAppArgs', *args)
      end

      # @return [[]byte] Accounts listed in the ApplicationCall transaction (v2)
      def accounts(*args)
        opcode('Accounts', *args)
      end

      # @return [uint64] Number of Accounts (v2)
      def num_accounts(*args)
        opcode('NumAccounts', *args)
      end

      # @return [[]byte] Approval program (v2)
      def approval_program(*args)
        opcode('ApprovalProgram', *args)
      end

      # @return [[]byte] Clear state program (v2)
      def clear_state_program(*args)
        opcode('ClearStateProgram', *args)
      end

      # @return [[]byte] 32 byte Sender's new AuthAddr (v2)
      def rekey_to(*args)
        opcode('RekeyTo', *args)
      end

      # @return [uint64] Asset ID in asset config transaction (v2)
      def config_asset(*args)
        opcode('ConfigAsset', *args)
      end

      # @return [uint64] Total number of units of this asset created (v2)
      def config_asset_total(*args)
        opcode('ConfigAssetTotal', *args)
      end

      # @return [uint64] Number of digits to display after the decimal place when displaying the asset (v2)
      def config_asset_decimals(*args)
        opcode('ConfigAssetDecimals', *args)
      end

      # @return [uint64] Whether the asset's slots are frozen by default or not, 0 or 1 (v2)
      def config_asset_default_frozen(*args)
        opcode('ConfigAssetDefaultFrozen', *args)
      end

      # @return [[]byte] Unit name of the asset (v2)
      def config_asset_unit_name(*args)
        opcode('ConfigAssetUnitName', *args)
      end

      # @return [[]byte] The asset name (v2)
      def config_asset_name(*args)
        opcode('ConfigAssetName', *args)
      end

      # @return [[]byte] URL (v2)
      def config_asset_url(*args)
        opcode('ConfigAssetURL', *args)
      end

      # @return [[]byte] 32 byte commitment to some unspecified asset metadata (v2)
      def config_asset_metadata_hash(*args)
        opcode('ConfigAssetMetadataHash', *args)
      end

      # @return [[]byte] 32 byte address (v2)
      def config_asset_manager(*args)
        opcode('ConfigAssetManager', *args)
      end

      # @return [[]byte] 32 byte address (v2)
      def config_asset_reserve(*args)
        opcode('ConfigAssetReserve', *args)
      end

      # @return [[]byte] 32 byte address (v2)
      def config_asset_freeze(*args)
        opcode('ConfigAssetFreeze', *args)
      end

      # @return [[]byte] 32 byte address (v2)
      def config_asset_clawback(*args)
        opcode('ConfigAssetClawback', *args)
      end

      # @return [uint64] Asset ID being frozen or un-frozen (v2)
      def freeze_asset(*args)
        opcode('FreezeAsset', *args)
      end

      # @return [[]byte] 32 byte address of the account whose asset slot is being frozen or un-frozen (v2)
      def freeze_asset_account(*args)
        opcode('FreezeAssetAccount', *args)
      end

      # @return [uint64] The new frozen value, 0 or 1 (v2)
      def freeze_asset_frozen(*args)
        opcode('FreezeAssetFrozen', *args)
      end

      # @return [uint64] Foreign Assets listed in the ApplicationCall transaction (v3)
      def assets(*args)
        opcode('Assets', *args)
      end

      # @return [uint64] Number of Assets (v3)
      def num_assets(*args)
        opcode('NumAssets', *args)
      end

      # @return [uint64] Foreign Apps listed in the ApplicationCall transaction (v3)
      def applications(*args)
        opcode('Applications', *args)
      end

      # @return [uint64] Number of Applications (v3)
      def num_applications(*args)
        opcode('NumApplications', *args)
      end

      # @return [uint64] Number of global state integers in ApplicationCall (v3)
      def global_num_uint(*args)
        opcode('GlobalNumUint', *args)
      end

      # @return [uint64] Number of global state byteslices in ApplicationCall (v3)
      def global_num_byte_slice(*args)
        opcode('GlobalNumByteSlice', *args)
      end

      # @return [uint64] Number of local state integers in ApplicationCall (v3)
      def local_num_uint(*args)
        opcode('LocalNumUint', *args)
      end

      # @return [uint64] Number of local state byteslices in ApplicationCall (v3)
      def local_num_byte_slice(*args)
        opcode('LocalNumByteSlice', *args)
      end

      # @return [uint64] Number of additional pages for each of the application's approval and clear state programs. An ExtraProgramPages of 1 means 2048 more total bytes, or 1024 for each program. (v4)
      def extra_program_pages(*args)
        opcode('ExtraProgramPages', *args)
      end

      # @return [uint64] Marks an account nonparticipating for rewards (v5)
      def nonparticipation(*args)
        opcode('Nonparticipation', *args)
      end

      # @return [[]byte] Log messages emitted by an application call (only with itxn in v5). Application mode only (v5)
      def logs(*args)
        opcode('Logs', *args)
      end

      # @return [uint64] Number of Logs (only with itxn in v5). Application mode only (v5)
      def num_logs(*args)
        opcode('NumLogs', *args)
      end

      # @return [uint64] Asset ID allocated by the creation of an ASA (only with itxn in v5). Application mode only (v5)
      def created_asset_id(*args)
        opcode('CreatedAssetID', *args)
      end

      # @return [uint64] ApplicationID allocated by the creation of an application (only with itxn in v5). Application mode only (v5)
      def created_application_id(*args)
        opcode('CreatedApplicationID', *args)
      end

      # @return [[]byte] The last message emitted. Empty bytes if none were emitted. Application mode only (v6)
      def last_log(*args)
        opcode('LastLog', *args)
      end

      # @return [[]byte] 64 byte state proof public key commitment (v6)
      def state_proof_pk(*args)
        opcode('StateProofPK', *args)
      end
    end

    module AppFields
      # @return [[]byte] Bytecode of Approval Program
      def app_approval_program(*args)
        opcode('AppApprovalProgram', *args)
      end

      # @return [[]byte] Bytecode of Clear State Program
      def app_clear_state_program(*args)
        opcode('AppClearStateProgram', *args)
      end

      # @return [uint64] Number of uint64 values allowed in Global State
      def app_global_num_uint(*args)
        opcode('AppGlobalNumUint', *args)
      end

      # @return [uint64] Number of byte array values allowed in Global State
      def app_global_num_byte_slice(*args)
        opcode('AppGlobalNumByteSlice', *args)
      end

      # @return [uint64] Number of uint64 values allowed in Local State
      def app_local_num_uint(*args)
        opcode('AppLocalNumUint', *args)
      end

      # @return [uint64] Number of byte array values allowed in Local State
      def app_local_num_byte_slice(*args)
        opcode('AppLocalNumByteSlice', *args)
      end

      # @return [uint64] Number of Extra Program Pages of code space
      def app_extra_program_pages(*args)
        opcode('AppExtraProgramPages', *args)
      end

      # @return [[]byte] Creator address
      def app_creator(*args)
        opcode('AppCreator', *args)
      end

      # @return [[]byte] Address for which this application has authority
      def app_address(*args)
        opcode('AppAddress', *args)
      end
    end

    module AssetFields
      # @return [uint64] Total number of units of this asset (v1)
      def asset_total(*args)
        opcode('AssetTotal', *args)
      end

      # @return [uint64] See AssetParams.Decimals (v1)
      def asset_decimals(*args)
        opcode('AssetDecimals', *args)
      end

      # @return [uint64] Frozen by default or not (v1)
      def asset_default_frozen(*args)
        opcode('AssetDefaultFrozen', *args)
      end

      # @return [[]byte] Asset unit name (v1)
      def asset_unit_name(*args)
        opcode('AssetUnitName', *args)
      end

      # @return [[]byte] Asset name (v1)
      def asset_name(*args)
        opcode('AssetName', *args)
      end

      # @return [[]byte] URL with additional info about the asset (v1)
      def asset_url(*args)
        opcode('AssetURL', *args)
      end

      # @return [[]byte] Arbitrary commitment (v1)
      def asset_metadata_hash(*args)
        opcode('AssetMetadataHash', *args)
      end

      # @return [[]byte] Manager commitment (v1)
      def asset_manager(*args)
        opcode('AssetManager', *args)
      end

      # @return [[]byte] Reserve address (v1)
      def asset_reserve(*args)
        opcode('AssetReserve', *args)
      end

      # @return [[]byte] Freeze address (v1)
      def asset_freeze(*args)
        opcode('AssetFreeze', *args)
      end

      # @return [[]byte] Clawback address (v1)
      def asset_clawback(*args)
        opcode('AssetClawback', *args)
      end

      # @return [[]byte] Creator address (v5)
      def asset_creator(*args)
        opcode('AssetCreator', *args)
      end
    end

    module AccountFields
      # @return [uint64] Account balance in microalgos
      def acct_balance(*args)
        opcode('AcctBalance', *args)
      end

      # @return [uint64] in microalgos (Minimum required blance for account)
      def acct_min_balance(*args)
        opcode('AcctMinBalance', *args)
      end

      # @return [[]byte] Address the account is rekeyed to.
      def acct_auth_addr(*args)
        opcode('AcctAuthAddr', *args)
      end
    end

    module GlobalFields
      # @return [uint64] microalgos (v1)
      def min_txn_fee(*args)
        opcode('MinTxnFee', *args)
      end

      # @return [uint64] microalgos (v1)
      def min_balance(*args)
        opcode('MinBalance', *args)
      end

      # @return [uint64] rounds (v1)
      def max_txn_life(*args)
        opcode('MaxTxnLife', *args)
      end

      # @return [[]byte] 32 byte address of all zero bytes (v1)
      def zero_address(*args)
        opcode('ZeroAddress', *args)
      end

      # @return [uint64] Number of transactions in this atomic transaction group. At least 1 (v1)
      def group_size(*args)
        opcode('GroupSize', *args)
      end

      # @return [uint64] Maximum supported version (v2)
      def logic_sig_version(*args)
        opcode('LogicSigVersion', *args)
      end

      # @return [uint64] Current round number. Application mode only. (v2)
      def round(*args)
        opcode('Round', *args)
      end

      # @return [uint64] Last confirmed block UNIX timestamp. Fails if negative. Application mode only. (v2)
      def latest_timestamp(*args)
        opcode('LatestTimestamp', *args)
      end

      # @return [uint64] ID of current application executing. Application mode only. (v2)
      def current_application_id(*args)
        opcode('CurrentApplicationID', *args)
      end

      # @return [[]byte] Address of the creator of the current application. Application mode only. (v3)
      def creator_address(*args)
        opcode('CreatorAddress', *args)
      end

      # @return [[]byte] Address that the current application controls. Application mode only. (v5)
      def current_application_address(*args)
        opcode('CurrentApplicationAddress', *args)
      end

      # @return [[]byte] ID of the transaction group. 32 zero bytes if the transaction is not part of a group. (v5)
      def group_id(*args)
        opcode('GroupID', *args)
      end

      # @return [uint64] The remaining cost that can be spent by opcodes in this program. (v6)
      def opcode_budget(*args)
        opcode('OpcodeBudget', *args)
      end

      # @return [uint64] The application ID of the application that called this application. 0 if this application is at the top-level. Application mode only. (v6)
      def caller_application_id(*args)
        opcode('CallerApplicationID', *args)
      end

      # @return [[]byte] The application address of the application that called this application. ZeroAddress if this application is at the top-level. Application mode only. (v6)
      def caller_application_address(*args)
        opcode('CallerApplicationAddress', *args)
      end
    end

    module App
      extend Opcodes
      extend AppFields

      def self.opcode(field, app_id = nil)
        app_params_get field, app_id
      end
    end

    module Asset
      extend Opcodes
      extend AssetFields

      def self.opcode(field, asset = nil)
        asset_params_get field, asset
      end
    end

    module Account
      extend Opcodes
      extend AccountFields

      def self.opcode(field, account = nil)
        acct_params_get field, account
      end
    end

    module Txn
      extend Opcodes
      extend TxnFields

      def self.opcode(field)
        txn field
      end
    end

    module Gtxn
      extend TxnFields
      extend Opcodes

      def self.opcode(field, index)
        gtxn index, field
      end

      def self.[](index)
        GroupTransaction.new(index)
      end
    end

    class GroupTransaction
      include TxnFields
      include Opcodes

      def initialize(index)
        @index = index
      end

      def opcode(field)
        gtxn @index, field
      end
    end

    module Txna
      extend Opcodes
      extend TxnFields

      def self.opcode(field, index)
        txna field, index
      end
    end

    module Global
      extend Opcodes
      extend GlobalFields

      def self.opcode(field)
        global field
      end
    end
  end
end
