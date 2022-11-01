# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'

class GlobalTests < Minitest::Test
  include TestMethods

  {
    min_txn_fee: 'MinTxnFee',
    min_balance: 'MinBalance',
    max_txn_life: 'MaxTxnLife',
    zero_address: 'ZeroAddress',
    group_size: 'GroupSize',
    logic_sig_version: 'LogicSigVersion',
    round: 'Round',
    latest_timestamp: 'LatestTimestamp',
    current_application_id: 'CurrentApplicationID',
    creator_address: 'CreatorAddress',
    group_id: 'GroupID',
    opcode_budget: 'OpcodeBudget',
    caller_application_id: 'CallerApplicationID',
    caller_application_address: 'CallerApplicationAddress'
  }.each do |meth, enum|
    define_method("test_global_#{meth}") do
      compile_test_last("global.#{meth}", "global #{enum}")
    end
  end

  def test_global_put
    compile_test 'global["key"] = 123', ['byte "key"', 'int 123', 'app_global_put']
  end

  def test_app_local_get
    compile_test 'global["key"]', ['byte "key"', 'app_global_get']
  end
end
