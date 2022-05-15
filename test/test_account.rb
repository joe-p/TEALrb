# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'
class AppTests < Minitest::Test
  include TestMethods

  {
    acct_balance: 'AcctBalance',
    acct_min_balance: 'AcctMinBalance',
    acct_auth_addr: 'AcctAuthAddr'
  }.each do |meth, enum|
    define_method("test_account_#{meth}") do
      compile_test_last("Account.#{meth}", "acct_params_get #{enum}")
    end
  end
end
