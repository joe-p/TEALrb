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

class IfElsifElsifElseTest < TEALrb::Contract
  def main
    if 1 # rubocop:disable Lint/LiteralAsCondition
      2
    elsif 3 # rubocop:disable Lint/LiteralAsCondition
      4
    elsif 5 # rubocop:disable Lint/LiteralAsCondition
      6
    else
      7
    end
  end
end

class IfTests < Minitest::Test
  def if_test(contract_class, expected_teal)
    contract_class.src_map = false
    contract = contract_class.new
    contract.generate_source_map(contract.formatted_teal)
    assert_equal(expected_teal, contract.teal[1..])
  end

  def test_if
    if_test(IfTest, ['if1_condition:', 'int 1', 'bz if1_end', 'if1_logic:', 'int 2', 'if1_end:'])
  end

  def test_if_else
    if_test(IfElseTest,
            ['if1_condition:', 'int 1', 'bz if1_else', 'if1_logic:', 'int 2', 'b if1_end', 'if1_else:', 'int 3',
             'if1_end:'])
  end

  def test_if_elsif
    if_test(IfElsifTest,
            ['if1_condition:', 'int 1', 'bz if1_elsif1_condition', 'if1_logic:', 'int 2', 'b if1_end',
             'if1_elsif1_condition:', 'int 3', 'bz if1_end', 'if1_elsif1_logic:', 'int 4', 'if1_end:'])
  end

  def test_if_elsif_else
    if_test(IfElsifElseTest,
            ['if1_condition:', 'int 1', 'bz if1_elsif1_condition', 'if1_logic:', 'int 2', 'b if1_end',
             'if1_elsif1_condition:', 'int 3', 'bz if1_else', 'if1_elsif1_logic:', 'int 4', 'b if1_end', 'if1_else:',
             'int 5', 'if1_end:'])
  end

  def test_if_elsif_elsif_else
    if_test(IfElsifElsifElseTest, ['if1_condition:', 'int 1', 'bz if1_elsif1_condition', 'if1_logic:',
                                   'int 2', 'b if1_end', 'if1_elsif1_condition:', 'int 3', 'bz if1_elsif2_condition',
                                   'if1_elsif1_logic:', 'int 4', 'b if1_end', 'if1_elsif2_condition:', 'int 5',
                                   'bz if1_else', 'if1_elsif2_logic:', 'int 6', 'b if1_end', 'if1_else:', 'int 7',
                                   'if1_end:'])
  end
end
