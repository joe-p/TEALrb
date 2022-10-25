# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'

class WhileTest < TEALrb::Contract
  def main
    @scratch['i'] = 1

    while @scratch['i'] < 3
      @scratch['i'] = @scratch['i'] + 1
    end
  end
end

class WhileTests < Minitest::Test
  def while_test(contract_class, expected_teal)
    contract_class.src_map = false
    contract = contract_class.new
    assert_equal(expected_teal, contract.teal[1..])
  end

  def test_while
    while_test(WhileTest,
               ['int 1', 'store 0 // i', 'while0:', 'load 0 // i', 'int 3', '<', 'bz end_while0', 'load 0 // i',
                'int 1', '+', 'store 0 // i', 'b while0', 'end_while0:'])
  end
end
