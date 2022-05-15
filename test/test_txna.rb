# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'
class TxnaTests < Minitest::Test
  include TestMethods

  TXN_FIELD_HASH.each do |meth, enum|
    define_method("test_txna_#{meth}") do
      compile_test_last("Txna[0].#{meth}", "txna #{enum} 0")
    end
  end
end
