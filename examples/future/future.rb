# frozen_string_literal: true

require_relative '../../lib/tealrb'
require 'pry'

class Future < TEALrb::Contract
  @version = 8
  def main
    1
    2
    add
    assert account(this_txn.sender).balance == accounts[2].balance

    box['hello'] = 'world'
    box['foo']

    inner_txn.begin
    inner_txn.type_enum = txn_type.pay
    inner_txn.receiver = this_txn.sender
    inner_txn.amount = 100_000
    inner_txn.fee = 0
    inner_txn.submit

    group_txns[1 + 1].sender

    global['hello'] = 'world'
    global['foo']
    global.min_txn_fee
    global('MinBalance')

    app(1).address
    apps[1].address

    asset(1).creator
    assets[1].creator

    logs[1]
    app_args[1]

    local[this_txn.sender]['hello'] = 'world'
    local[this_txn.sender]['foo']
  end
end

f = Future.new
puts f.formatted_teal
f.dump(__dir__)
