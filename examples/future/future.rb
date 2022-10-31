# frozen_string_literal: true

require_relative '../../lib/tealrb'
require 'pry'

class Future < TEALrb::Contract
  def main
    1
    2
    add
    assert account(this_txn.sender).balance == accounts[2].balance
  end
end

f = Future.new
puts f.formatted_teal
f.dump(__dir__)
