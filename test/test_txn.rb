# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'
class AppTests < Minitest::Test
  include TestMethods

  TXN_FIELD_HASH.each do |meth, enum|
    define_method("test_txn_#{meth}") do
      compile_test_last("Txn.#{meth}", "txn #{enum}")
    end
  end
end
