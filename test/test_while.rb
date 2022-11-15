# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'

class WhileTest < TEALrb::Contract
  def main
    $i = 1

    while $i < 3
      $i = $i + 1
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
               ['int 1', 'store 0 // i', 'while0_condition:', 'load 0 // i', 'int 3', '<', 'bz while0_end',
                'while0_logic:', 'load 0 // i', 'int 1', '+', 'store 0 // i', 'b while0_condition', 'while0_end:'])
  end
end
