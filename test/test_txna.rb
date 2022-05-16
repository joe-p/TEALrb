# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'
class TxnaTests < Minitest::Test
  include TestMethods

  def test_txna_application_args
    compile_test_last('Txna.application_args[0]', 'txna ApplicationArgs 0')
  end

  def test_txna_accounts
    compile_test_last('Txna.accounts[0]', 'txna Accounts 0')
  end

  def test_txna_assets
    compile_test_last('Txna.assets[0]', 'txna Assets 0')
  end

  def test_txna_applications
    compile_test_last('Txna.applications[0]', 'txna Applications 0')
  end

  def test_txna_logs
    compile_test_last('Txna.logs[0]', 'txna Logs 0')
  end
end
