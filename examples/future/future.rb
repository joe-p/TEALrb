# frozen_string_literal: true

require_relative '../../lib/tealrb'
require 'pry'

class Future < TEALrb::Contract
  @debug = true

  def main1
    if this_txn.sender == this_txn.receiver
      1
      2
      add
    end
  end

  def main2
    if this_txn.sender == this_txn.receiver
      1
      2
      add
    else
      'hello'
      'world'
      concat
    end
  end

  def main3
    if this_txn.sender == this_txn.receiver
      1
      2
      add
    elsif this_txn.sender == this_txn.close_remainder_to
      log('CLOSE')
    else
      'hello'
      'world'
      concat
    end
  end

  def main
    log('HI') if this_txn.sender == this_txn.receiver
  end
end

f = Future.new
puts f.formatted_teal
f.dump(__dir__)
