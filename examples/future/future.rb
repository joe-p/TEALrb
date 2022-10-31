# frozen_string_literal: true

require_relative '../../lib/tealrb'
require 'pry'

class DemoContract < TEALrb::Contract
  def main
    1
    2
    add
    assert account(this_txn.sender).balance == account[2].balance
  end
end

approval = DemoContract.new
File.write("#{__dir__}/future.teal", approval.formatted_teal)
File.write("#{__dir__}/future.json", JSON.pretty_generate(approval.abi_hash))
puts approval.formatted_teal
approval.dump
