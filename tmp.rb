# frozen_string_literal: true

# This is a temporary file used during development for quick testing that will be deleted upon release

require_relative 'lib/tealrb'
require 'pry'

class TestContract < TEALrb::ContractV2
  subroutine def save(key, value)
    app_global_put(key, value)
  end

  teal def teal_method(input)
    "teal method: #{input}"
  end

  def ruby_method(input)
    "ruby method: #{input}"
  end

  def main
    # Subroutine
    save_var = save('Hello', 2)

    # Ruby Method
    ruby_var = byte(ruby_method('ruby method input'))

    # TEAL method
    teal_var = teal_method('teal method input')

    if save_var
      ruby_var
    elsif teal_var
      'in elsif c'
    else
      'in else'
    end
  end
end
contract = TestContract.new
contract.compile
puts contract.teal
