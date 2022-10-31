# frozen_string_literal: true

# rubocop:disable Lint/UnusedMethodArgument

module TEALrb
  module Opcodes
    class AccountLocal
      def initialize(account)
        @account = account
      end

      def [](key)
        ExtendedOpcodes.app_local_get @account, key
      end

      def []=(key, value)
        ExtendedOpcodes.app_local_put @account, key, value
      end
    end

    module Local
      def self.[](account)
        AccountLocal.new account
      end
    end

    module TxnType
      class << self
        private

        def txn_type_int(type)
          TEAL.instance << "int #{type}"
        end
      end

      def self.unknown
        txn_type_int 'unknown'
      end

      def self.pay
        txn_type_int 'pay'
      end

      def self.key_registration
        txn_type_int 'keyreg'
      end

      def self.asset_config
        txn_type_int 'acfg'
      end

      def self.asset_transfer
        txn_type_int 'axfer'
      end

      def self.asset_freeze
        txn_type_int 'afrz'
      end

      def self.application_call
        txn_type_int 'appl'
      end
    end

    # TODO: Create TxnaFields to separate array fields

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
        Accounts.new
      end

      # @return [[]byte] ID of the transaction group. 32 zero bytes if the transaction is not part of a group. (v5)
      def group_id(*args)
        opcode('GroupID', *args)
      end

      # @return [uint64] The remaining cost that can be spent by opcodes in this program. (v6)
      def opcode_budget(*args)
        opcode('OpcodeBudget', *args)
      end

      # @return [uint64] The application ID of the application that called this application.
      #   0 if this application is at the top-level. Application mode only. (v6)
      def caller_application_id(*args)
        opcode('CallerApplicationID', *args)
        Application.new
      end

      # @return [[]byte] The application address of the application that called this application.
      #   ZeroAddress if this application is at the top-level. Application mode only. (v6)
      def caller_application_address(*args)
        opcode('CallerApplicationAddress', *args)
      end
    end

    module Txn
      extend TxnFields

      def self.opcode(field)
        ExtendedOpcodes.txn field
      end
    end

    module InnerTxn
      extend TxnFields

      class << self
        def opcode(field, value)
          ExtendedOpcodes.itxn_field field
        end

        def begin
          ExtendedOpcodes.itxn_begin
        end

        def submit
          ExtendedOpcodes.itxn_submit
        end

        def next
          ExtendedOpcodes.itxn_next
        end

        # @!method tx_id=(value)
        # @!method application_id=(value)
        # @!method on_completion=(value)
        # @!method application_args=(value)
        # @!method num_app_args=(value)
        # @!method accounts=(value)
        # @!method num_accounts=(value)
        # @!method approval_program=(value)
        # @!method clear_state_program=(value)
        # @!method rekey_to=(value)
        # @!method config_asset=(value)
        # @!method config_asset_total=(value)
        # @!method receiver=(value)
        # @!method config_asset_decimals=(value)
        # @!method config_asset_default_frozen=(value)
        # @!method config_asset_unit_name=(value)
        # @!method config_asset_name=(value)
        # @!method config_asset_url=(value)
        # @!method config_asset_metadata_hash=(value)
        # @!method config_asset_reserve=(value)
        # @!method config_asset_freeze=(value)
        # @!method config_asset_manager=(value)
        # @!method config_asset_clawback=(value)
        # @!method freeze_asset=(value)
        # @!method freeze_asset_account=(value)
        # @!method freeze_asset_frozen=(value)
        # @!method assets=(value)
        # @!method num_assets=(value)
        # @!method applications=(value)
        # @!method num_applications=(value)
        # @!method global_num_uint=(value)
        # @!method global_num_byte_slice=(value)
        # @!method local_num_uint=(value)
        # @!method local_num_byte_slice=(value)
        # @!method extra_program_pages=(value)
        # @!method nonparticipation=(value)
        # @!method logs=(value)
        # @!method num_logs=(value)
        # @!method created_asset_id=(value)
        # @!method created_application_id=(value)
        # @!method last_log=(value)
        # @!method state_proof_pk=(value)
        # @!method type=(value)
        # @!method amount=(value)
        # @!method sender=(value)
        # @!method note=(value)
        # @!method fee=(value)
        # @!method first_valid=(value)
        # @!method first_valid_time=(value)
        # @!method last_valid=(value)
        # @!method lease=(value)
        # @!method close_remainder_to=(value)
        # @!method vote_pk=(value)
        # @!method selection_pk=(value)
        # @!method vote_first=(value)
        # @!method vote_last=(value)
        # @!method vote_key_dilution=(value)
        # @!method type_enum=(value)
        # @!method xfer_asset=(value)
        # @!method asset_amount=(value)
        # @!method asset_sender=(value)
        # @!method asset_receiver=(value)
        # @!method asset_close_to=(value)
        # @!method group_index=(value)
        TxnFields.instance_methods.each do |m|
          define_method("#{m}=") do |value|
            send(m, value)
          end
        end
      end
    end

    module Gtxn
      extend TxnFields

      def self.opcode(field, index)
        ExtendedOpcodes.gtxn index, field
      end

      def self.[](index)
        GroupTransaction.new(index)
      end
    end

    module Gtxns
      extend TxnFields

      def self.opcode(field)
        ExtendedOpcodes.gtxns field
      end

      def self.[](index)
        self
      end
    end

    class GroupTransaction
      include TxnFields

      def initialize(index)
        @index = index
      end

      def opcode(field)
        ExtendedOpcodes.gtxn @index, field
      end
    end

    class TxnArray
      TEALrb::Opcodes::BINARY_OPCODE_METHOD_MAPPING.each do |meth, opcode|
        define_method(meth) do |other|
          ExtendedOpcodes.send(opcode, self, other)
        end
      end

      TEALrb::Opcodes::UNARY_OPCODE_METHOD_MAPPING.each do |meth, opcode|
        define_method(meth) do
          ExtendedOpcodes.send(opcode, self)
        end
      end

      def self.[](index)
        new[index]
      end

      def [](index)
        if index.is_a? Integer
          ExtendedOpcodes.txna @field, index
        else
          ExtendedOpcodes.txnas @field
        end

        self
      end
    end

    class ApplicationArgs < TxnArray
      def initialize
        super
        @field = 'ApplicationArgs'
      end
    end

    class Logs < TxnArray
      def initialize
        super
        @field = 'Logs'
      end
    end

    class Account < TxnArray
      def initialize(account = nil)
        super()
        @field = 'Accounts'
      end

      def asset_balance?(asa_id = nil)
        ExtendedOpcodes.asset_holding_exists? 'AssetBalance'
      end

      def asset_balance(asa_id = nil)
        ExtendedOpcodes.asset_holding_value 'AssetBalance'
      end

      def asset_frozen?(asa_id = nil)
        ExtendedOpcodes.asset_frozen_exists? 'AssetFrozen'
      end

      def asset_frozen_value(asa_id = nil)
        ExtendedOpcodes.asset_frozen_value 'AssetFrozen'
      end

      def min_balance
        ExtendedOpcodes.acct_param_value 'AcctMinBalance'
      end

      def balance
        ExtendedOpcodes.acct_param_value 'AcctBalance'
      end

      def auth_addr
        ExtendedOpcodes.acct_param_value 'AcctAuthAddr'
      end

      def balance?
        ExtendedOpcodes.acct_has_balance?
      end
    end

    class Application < TxnArray
      def initialize(app = nil)
        super()
        @field = 'Applications'
      end

      # @return [[]byte] Bytecode of Approval Program
      def approval_program(*_args)
        ExtendedOpcodes.app_param_value 'AppApprovalProgram'
      end

      # @return [[]byte] Bytecode of Clear State Program
      def clear_state_program(*_args)
        ExtendedOpcodes.app_param_value 'AppClearStateProgram'
      end

      # @return [uint64] Number of uint64 values allowed in Global State
      def global_num_uint(*_args)
        ExtendedOpcodes.app_param_value 'AppGlobalNumUint'
      end

      # @return [uint64] Number of byte array values allowed in Global State
      def global_num_byte_slice(*_args)
        ExtendedOpcodes.app_param_value 'AppGlobalNumByteSlice'
      end

      # @return [uint64] Number of uint64 values allowed in Local State
      def local_num_uint(*_args)
        ExtendedOpcodes.app_param_value 'AppLocalNumUint'
      end

      # @return [uint64] Number of byte array values allowed in Local State
      def local_num_byte_slice(*_args)
        ExtendedOpcodes.app_param_value 'AppLocalNumByteSlice'
      end

      # @return [uint64] Number of Extra Program Pages of code space
      def extra_program_pages(*_args)
        ExtendedOpcodes.app_param_value 'AppExtraProgramPages'
      end

      # @return [[]byte] Creator address
      def creator(*_args)
        ExtendedOpcodes.app_param_value 'AppCreator'
        Accounts.new
      end

      # @return [[]byte] Address for which this application has authority
      def address(*_args)
        ExtendedOpcodes.app_param_value 'AppAddress'
        Account.new
      end

      # @return [[]byte] Bytecode of Approval Program
      def approval_program?(*_args)
        ExtendedOpcodes.app_param_exists? 'AppApprovalProgram'
      end

      # @return [[]byte] Bytecode of Clear State Program
      def clear_state_program?(*_args)
        ExtendedOpcodes.app_param_exists? 'AppClearStateProgram'
      end

      # @return [uint64] Number of uint64 values allowed in Global State
      def global_num_uint?(*_args)
        ExtendedOpcodes.app_param_exists? 'AppGlobalNumUint'
      end

      # @return [uint64] Number of byte array values allowed in Global State
      def global_num_byte_slice?(*_args)
        ExtendedOpcodes.app_param_exists? 'AppGlobalNumByteSlice'
      end

      # @return [uint64] Number of uint64 values allowed in Local State
      def local_num_uint?(*_args)
        ExtendedOpcodes.app_param_exists? 'AppLocalNumUint'
      end

      # @return [uint64] Number of byte array values allowed in Local State
      def local_num_byte_slice?(*_args)
        ExtendedOpcodes.app_param_exists? 'AppLocalNumByteSlice'
      end

      # @return [uint64] Number of Extra Program Pages of code space
      def extra_program_pages?(*_args)
        ExtendedOpcodes.app_param_exists? 'AppExtraProgramPages'
      end

      # @return [[]byte] Creator address
      def creator?(*_args)
        ExtendedOpcodes.app_param_exists? 'AppCreator'
      end

      # @return [[]byte] Address for which this application has authority
      def address?(*_args)
        ExtendedOpcodes.app_param_exists? 'AppAddress'
      end

      def num_approval_pages?
        ExtendedOpcodes.app_param_exists? 'NumApprovalProgramPages'
      end

      def num_approval_pages
        ExtendedOpcodes.app_param_value 'NumApprovalProgramPages'
      end

      def num_clear_pages?
        ExtendedOpcodes.app_param_exists? 'NumClearProgramPages'
      end

      def num_clear_pages
        ExtendedOpcodes.app_param_value 'NumClearProgramPages'
      end

      def global_value(key)
        ExtendedOpcodes.app_global_ex_value
      end

      def global_exists?(key)
        ExtendedOpcodes.app_global_ex_exists?
      end

      def local_value(account, key)
        ExtendedOpcodes.app_local_ex_value
      end

      def local_exists?(account, key)
        ExtendedOpcodes.app_local_ex_exists?
      end
    end

    class Asset < TxnArray
      def initialize(asset = nil)
        super()
        @field = 'Assets'
      end

      def total
        ExtendedOpcodes.asset_param_value 'AssetTotal'
      end

      def decimals
        ExtendedOpcodes.asset_param_value 'AssetDecimals'
      end

      def default_frozen
        ExtendedOpcodes.asset_param_value 'AssetDefaultFrozen'
      end

      def name
        ExtendedOpcodes.asset_param_value 'AssetName'
      end

      def unit_name
        ExtendedOpcodes.asset_param_value 'AssetUnitName'
      end

      def url
        ExtendedOpcodes.asset_param_value 'AssetURL'
      end

      def metadata_hash
        ExtendedOpcodes.asset_param_value 'AssetMetadataHash'
      end

      def manager
        ExtendedOpcodes.asset_param_value 'AssetManager'
      end

      def reserve
        ExtendedOpcodes.asset_param_value 'AssetReserve'
      end

      def freeze
        ExtendedOpcodes.asset_param_value 'AssetFreeze'
      end

      def clawback
        ExtendedOpcodes.asset_param_value 'AssetClawback'
      end

      def creator
        ExtendedOpcodes.asset_param_value 'AssetCreator'
      end

      def total?
        ExtendedOpcodes.asset_param_exists? 'AssetTotal'
      end

      def decimals?
        ExtendedOpcodes.asset_param_exists? 'AssetDecimals'
      end

      def default_frozen?
        ExtendedOpcodes.asset_param_exists? 'AssetDefaultFrozen'
      end

      def name?
        ExtendedOpcodes.asset_param_exists? 'AssetName'
      end

      def unit_name?
        ExtendedOpcodes.asset_param_exists? 'AssetUnitName'
      end

      def url?
        ExtendedOpcodes.asset_param_exists? 'AssetURL'
      end

      def metadata_hash?
        ExtendedOpcodes.asset_param_exists? 'AssetMetadataHash'
      end

      def manager?
        ExtendedOpcodes.asset_param_exists? 'AssetManager'
      end

      def reserve?
        ExtendedOpcodes.asset_param_exists? 'AssetReserve'
      end

      def freeze?
        ExtendedOpcodes.asset_param_exists? 'AssetFreeze'
      end

      def clawback?
        ExtendedOpcodes.asset_param_exists? 'AssetClawback'
      end

      def creator?
        ExtendedOpcodes.asset_param_exists? 'AssetCreator'
      end
    end

    module Txna
      def self.application_args
        ApplicationArgs.new
      end

      def self.accounts
        Accounts.new
      end

      def self.assets
        Assets.new
      end

      def self.applications
        Apps.new
      end

      def self.logs
        Logs.new
      end
    end

    class Box
      def self.[](key)
        ExtendedOpcodes.box_value key
      end

      def self.[]=(key, value)
        ExtendedOpcodes.box_put key, value
      end
    end

    module Global
      extend GlobalFields

      def self.opcode(field)
        ExtendedOpcodes.global field
      end

      def self.[](key)
        ExtendedOpcodes.app_global_get key
      end

      def self.[]=(key, value)
        ExtendedOpcodes.app_global_put key, value
      end
    end

    module AppArgs
      def self.[](index)
        Txna.application_args[index]
      end
    end

    module ByteOpcodes
      def byte_b64(b64)
        TEAL.instance << "byte b64 #{b64}"
      end

      def byte_b32(b32)
        TEAL.instance << "byte b32 #{b32}"
      end
    end

    module AllOpcodes
      include TEALOpcodes
      include MaybeOps
      include ByteOpcodes
    end

    module ExtendedOpcodes
      extend AllOpcodes
    end

    class TransactionBase
      include TxnFields
    end

    class Pay < TransactionBase; end

    class Keyreg < TransactionBase; end

    class Keyreg < TransactionBase; end

    class Axfer < TransactionBase; end

    class Afrz < TransactionBase; end

    class Appl < TransactionBase; end

    class Accounts < Account; end

    class Assets < Asset; end

    class Apps < Application; end
  end
end
# rubocop:enable Lint/UnusedMethodArgument
