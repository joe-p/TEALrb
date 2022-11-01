# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'

class AppTests < Minitest::Test
  include TestMethods

  {
    balance: 'AcctBalance',
    min_balance: 'AcctMinBalance',
    auth_addr: 'AcctAuthAddr'
  }.each do |meth, enum|
    define_method("test_account_#{meth}") do
      compile_test_last("accounts[0].#{meth}", ['txna Accounts 0', "acct_params_get #{enum}", 'pop'], 3)
    end
  end

  def test_account_balance?
    compile_test_last('accounts[0].balance?', ['txna Accounts 0', 'acct_params_get AcctBalance', 'swap', 'pop'], 4)
  end
end
