# frozen_string_literal: true

module TEALrb
  class InnerTxn
    def initialize(contract)
      @contract = contract
    end

    def begin
      @contract.itxn_begin
    end

    def submit
      @contract.itxn_submit
    end

    def next
      @contract.itxn_next
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
        if m == :application_id
          @contract.itxn_field 'ApplicationID'
        else
          @contract.itxn_field m.to_s.split('_').collect(&:capitalize).join, value
        end
      end
    end
  end
end
