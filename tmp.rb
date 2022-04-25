# frozen_string_literal: true

require_relative 'lib/tealrb'
require 'pry'

class TestContract < TEALrb::ContractV2
  def main
    a = app_global_put('Some Key', 2)
    if a
      'if block'
    elsif gtxnsa(1, 2, app_global_put('Some Key', 3))
      'elsif block'
    else
      'else block'
    end
  end

  def raw
    a = -> { app_global_put(byte('Some Key'), int(2)) }
    IfBlock.new(@teal,  a.call ) do
      byte('if block')
    end.elsif( gtxnsa(1, 2, app_global_put(byte('Some Key'), int(3))) ) do
      byte('elsif block')
    end.else do
      byte('else block')
    end
  end
end
contract = TestContract.new
contract.compile
puts contract.teal
