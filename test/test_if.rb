# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'

class IfTest < TEALrb::Contract
  def main
    if 1 # rubocop:disable Style/GuardClause, Lint/LiteralAsCondition
      2
    end
  end
end

class IfElseTest < TEALrb::Contract
  def main
    if 1 # rubocop:disable Lint/LiteralAsCondition
      2
    else
      3
    end
  end
end

class IfElsifTest < TEALrb::Contract
  def main
    if 1 # rubocop:disable Lint/LiteralAsCondition
      2
    elsif 3 # rubocop:disable Lint/LiteralAsCondition
      4
    end
  end
end

class IfElsifElseTest < TEALrb::Contract
  def main
    if 1 # rubocop:disable Lint/LiteralAsCondition
      2
    elsif 3 # rubocop:disable Lint/LiteralAsCondition
      4
    else
      5
    end
  end
end

class IfTests < Minitest::Test
  def if_test(contract_class, expected_teal)
    contract = contract_class.new
    contract_class.src_map = false
    contract.compile
    assert_equal(expected_teal, contract.teal[1..])
  end

  def test_if
    if_test(IfTest, ['int 1', 'bz if0_else0', 'int 2', 'b if0_end', 'if0_else0:', 'if0_end:'])
  end

  def test_if_else
    if_test(IfElseTest, ['int 1', 'bz if0_else0', 'int 2', 'b if0_end', 'if0_else0:', 'int 3', 'if0_end:'])
  end

  def test_if_elsif
    if_test(IfElsifTest,
            ['int 1', 'bz if0_else0', 'int 2', 'b if0_end', 'if0_else0:', 'int 3', 'bz if0_else1', 'int 4', 'b if0_end',
             'if0_else1:', 'if0_end:'])
  end

  def test_if_elsif_esle
    if_test(IfElsifElseTest,
            ['int 1', 'bz if0_else0', 'int 2', 'b if0_end', 'if0_else0:', 'int 3', 'bz if0_else1', 'int 4', 'b if0_end',
             'if0_else1:', 'int 5', 'if0_end:'])
  end
end
