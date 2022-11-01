# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'

class AppTests < Minitest::Test
  include TestMethods

  {
    approval_program: 'AppApprovalProgram',
    clear_state_program: 'AppClearStateProgram',
    global_num_uint: 'AppGlobalNumUint',
    global_num_byte_slice: 'AppGlobalNumByteSlice',
    local_num_uint: 'AppLocalNumUint',
    local_num_byte_slice: 'AppLocalNumByteSlice',
    extra_program_pages: 'AppExtraProgramPages',
    creator: 'AppCreator',
    address: 'AppAddress'
  }.each do |meth, enum|
    define_method("test_#{meth}") do
      compile_test_last("apps[0].#{meth}", ['txna Applications 0', "app_params_get #{enum}", 'pop'], 3)
    end
  end

  {
    approval_program?: 'AppApprovalProgram',
    clear_state_program?: 'AppClearStateProgram',
    global_num_uint?: 'AppGlobalNumUint',
    global_num_byte_slice?: 'AppGlobalNumByteSlice',
    local_num_uint?: 'AppLocalNumUint',
    local_num_byte_slice?: 'AppLocalNumByteSlice',
    extra_program_pages?: 'AppExtraProgramPages',
    creator?: 'AppCreator',
    address?: 'AppAddress'
  }.each do |meth, enum|
    define_method("test_#{meth}") do
      compile_test_last("apps[0].#{meth}", ['txna Applications 0', "app_params_get #{enum}", 'swap', 'pop'], 4)
    end
  end
end
