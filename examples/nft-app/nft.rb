# frozen_string_literal: true

require_relative '../../lib/tealrb'

# TEAL tested with https://github.com/joe-p/algo-nft-app/blob/e9428b4f59674e6844011896bff9ab76b16e7a44/tests/index.ts
class Approval < TEALrb::Contract
  @version = 5

  teal def init
    royalty_address = AppArgs[0]
    royalty_percent = btoi AppArgs[1]
    metadata = AppArgs[2]
    tx_methods = btoi AppArgs[3]

    Global['Royalty Address'] = royalty_address
    Global['Owner'] = Txn.sender
    Global['Highest Bidder'] = ''
    Global['Metadata'] = metadata

    Global['Royalty Percent'] = royalty_percent
    Global['Auction End'] = 0
    Global['TX Methods'] = tx_methods
    Global['Sale Price'] = 0
    Global['Highest Bid'] = 0

    approve
  end

  teal def start_auction
    payment = Gtxn[1]
    starting_price = btoi(AppArgs[1])
    duration = btoi(AppArgs[2])

    assert Global['TX Methods'] & 4
    assert payment.receiver == Global.current_application_address
    assert payment.amount == 100_000
    Global['Auction End'] = Global.latest_timestamp + duration
    Global['Highest Bid'] = starting_price

    approve
  end

  teal def start_sale
    price = btoi AppArgs[1]

    assert Global['TX Methods'] & 2
    assert Txn.sender == Global['Owner']
    Global['Sale Price'] = price
    approve
  end

  teal def end_sale
    assert Txn.sender == Global['Owner']
    Global['Sale Price'] = 0
    approve
  end

  teal def bid
    payment = Gtxn[1]
    app_call = Gtxn[0]
    highest_bidder = Global['Highest Bidder']
    highest_bid = Global['Highest Bid']

    assert Global.latest_timestamp < Global['Auction End']
    assert payment.amount > highest_bid
    assert app_call.sender == payment.sender

    if highest_bidder != ''
      pay(highest_bidder, highest_bid)
    end

    Global['Highest Bid'] = payment.amount
    Global['Highest Bidder'] = payment.sender
    approve
  end

  subroutine def pay(receiver, amount)
    itxn_begin
    itxn_field 'TypeEnum', TxnType.pay
    itxn_field 'Receiver', receiver
    itxn_field 'Amount', amount - 1000
    itxn_submit
  end

  teal def end_auction
    highest_bid = Global['Highest Bid']
    royalty_percent = Global['Royalty Percent']
    royalty_amount = highest_bid * royalty_percent / 100
    royalty_address = Global['Royalty Address']
    owner = Global['Owner']

    assert Global.latest_timestamp > Global['Auction End']
    pay(royalty_address, royalty_amount)
    pay(owner, highest_bid - royalty_amount)
    Global['Auction End'] = 0
    Global['Owner'] = Global['Highest Bidder']
    Global['Highest Bidder'] = ''
    approve
  end

  teal def transfer
    receiver = AppArgs[1]

    assert Global['TX Methods'] & 1
    assert Txn.sender == Global['Owner']
    Global['Owner'] = receiver
    approve
  end

  teal def buy
    royalty_payment = Gtxn[2]
    payment = Gtxn[1]
    royalty_amount = Global['Sale Price'] * Global['Royalty Percent'] / 100
    purchase_amount = Global['Sale Price'] - royalty_amount

    assert Global['Sale Price'] > 0

    # Verify senders are all the same
    assert royalty_payment.sender == payment.sender
    assert Txn.sender == payment.sender

    # Verify receivers are correct
    assert royalty_payment.receiver == Global['Royalty Address']
    assert payment.receiver == Global['Owner']

    # Verify amounts are correct
    assert royalty_payment.amount == royalty_amount
    assert payment.amount == purchase_amount

    Global['Owner'] = Txn.sender
    Global['Sale Price'] = 0
    approve
  end

  def main
    if Txn.application_id == 0
      init
    elsif AppArgs[0] == 'start_auction'
      start_auction
    elsif AppArgs[0] == 'start_sale'
      start_sale
    elsif AppArgs[0] == 'end_sale'
      end_sale
    elsif AppArgs[0] == 'bid'
      bid
    elsif AppArgs[0] == 'end_auction'
      end_auction
    elsif AppArgs[0] == 'transfer'
      transfer
    elsif AppArgs[0] == 'buy'
      buy
    else
      err
    end
  end
end

approval = Approval.new
approval.compile
File.write("#{__dir__}/nft_tealrb.teal", approval.teal_source)
