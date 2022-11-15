# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'

class AppTests < Minitest::Test
  include TestMethods

  TXN_FIELD_HASH.each do |meth, enum|
    define_method("test_gtxn_#{meth}") do
      compile_test_last("group_txns[0].#{meth}", "gtxn 0 #{enum}")
    end
  end
end
