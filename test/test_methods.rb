# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'

class TealTest < TEALrb::Contract
  teal :teal_method do |x, y|
    x / y
  end

  def main
    teal_method 1, 2
  end
end

class TealDefTest < TEALrb::Contract
  teal def teal_method(x, y)
    x / y
  end

  def main
    teal_method 1, 2
  end
end

class SubroutineTest < TEALrb::Contract
  subroutine :subroutine_method do |x, y|
    x / y
  end

  def main
    subroutine_method 1, 2
  end
end

class SubroutineDefTest < TEALrb::Contract
  subroutine def subroutine_method(x, y)
    x / y
  end

  def main
    subroutine_method 1, 2
  end
end

class ModuleTests < Minitest::Test
  SUBROUTINE_METHOD_TEAL = ['b main', 'subroutine_method: // subroutine_method(x, y)', 'store 200 // y',
                            'store 201 // x', 'load 201 // x', 'load 200 // y', '/', 'retsub', 'main:', 'int 1', 'int 2', 'callsub subroutine_method'].freeze

  TEAL_METHOD_TEAL = ['int 1', 'int 2', 'store 200 // y', 'store 201 // x', 'load 201 // x', 'load 200 // y',
                      '/'].freeze

  def method_test(contract_class, expected_teal)
    contract = contract_class.new
    contract.compile
    assert_equal(expected_teal, contract.teal[1..])
  end

  def test_teal
    method_test(TealTest, TEAL_METHOD_TEAL)
  end

  def test_teal_def
    method_test(TealDefTest, TEAL_METHOD_TEAL)
  end

  def test_subroutine
    method_test(SubroutineTest, SUBROUTINE_METHOD_TEAL)
  end

  def test_subroutine_def
    method_test(SubroutineDefTest, SUBROUTINE_METHOD_TEAL)
  end
end
