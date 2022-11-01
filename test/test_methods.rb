# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'

class SubroutineTest < TEALrb::Contract
  @src_map = false

  # @subroutine
  def subroutine_method(x, y)
    x / y
  end

  def main
    subroutine_method 1, 2
  end
end

class ModuleTests < Minitest::Test
  SUBROUTINE_METHOD_TEAL = ['b main', 'subroutine_method: // subroutine_method(x, y)', 'txn OnCompletion', 'int NoOp',
                            '==', 'assert', 'store 0 // subroutine_method: y [any] ',
                            'store 1 // subroutine_method: x [any] ', 'load 1 // subroutine_method: x [any] ',
                            'load 0 // subroutine_method: y [any] ', '/',
                            'retsub', 'main:', 'int 1', 'int 2', 'callsub subroutine_method'].freeze

  def method_test(contract_class, expected_teal)
    contract = contract_class.new
    assert_equal(expected_teal, contract.teal[1..])
  end

  def test_subroutine
    method_test(SubroutineTest, SUBROUTINE_METHOD_TEAL)
  end
end
