# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'
class AppTests < Minitest::Test
  include TestMethods

  {
    app_approval_program: 'AppApprovalProgram',
    app_clear_state_program: 'AppClearStateProgram',
    app_global_num_uint: 'AppGlobalNumUint',
    app_global_num_byte_slice: 'AppGlobalNumByteSlice',
    app_local_num_uint: 'AppLocalNumUint',
    app_local_num_byte_slice: 'AppLocalNumByteSlice',
    app_extra_program_pages: 'AppExtraProgramPages',
    app_creator: 'AppCreator',
    app_address: 'AppAddress'
  }.each do |meth, enum|
    define_method("test_app_#{meth}") do
      compile_test_last("App.#{meth}", "app_params_get #{enum}")
    end
  end
end
