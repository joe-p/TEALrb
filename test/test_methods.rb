# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'

class TealTest < TEALrb::Contract
  @src_map = false

  # @teal
  def teal_method(x, y)
    x / y
  end

  def main
    teal_method 1, 2
  end
end

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

  TEAL_METHOD_TEAL = ['int 1', 'int 2', 'store 0 // teal_method: y', 'store 1 // teal_method: x',
                      'load 1 // teal_method: x', 'load 0 // teal_method: y', '/'].freeze

  def method_test(contract_class, expected_teal)
    contract = contract_class.new
    contract.compile
    assert_equal(expected_teal, contract.teal[1..])
  end

  def test_teal
    method_test(TealTest, TEAL_METHOD_TEAL)
  end

  def test_subroutine
    method_test(SubroutineTest, SUBROUTINE_METHOD_TEAL)
  end
end
