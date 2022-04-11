require_relative 'lib/teal'
require 'pry'

include TEALrb

class Approval < TEAL
  def initialize(**kwargs)
    super
    @fee = 1000
  end

  teal def init 
    royalty_address = Txna.application_args(0)
    royalty_percent = btoi Txna.application_args(1)
    metadata = Txna.application_args(2)
    tx_methods = btoi Txna.application_args(3)
  
    app_global_put('Royalty Address', royalty_address)
    app_global_put('Owner', Txn.sender)
    app_global_put('Highest Bidder', '')
    app_global_put('Metadata', metadata )

    app_global_put('Royalty Percent', royalty_percent )
    app_global_put('Auction End', 0)
    app_global_put('TX Methods', tx_methods)
    app_global_put('Sale Price', 0)
    app_global_put('Highest Bid', 0)
  
    approve
  end

  teal def start_auction
    payment = Gtxn[1]
    starting_price = btoi(Txna.application_args(1))
    duration = btoi(Txna.application_args(2))
  
    err if !(app_global_get('TX Methods') & 4)
    err if !(payment.receiver == Global.current_application_address)
    err if !(payment.amount == 100000)
    app_global_put('Auction End', Global.latest_timestamp + duration)
    app_global_put('Highest Bid', starting_price)

    approve
  end

  teal def start_sale
    price = btoi Txna.application_args(1)

    err if !(app_global_get('TX Methods') & 2)
    err if !(Txn.sender == app_global_get('Owner'))
    app_global_put('Sale Price', price)
    approve
  end

  teal def end_sale
    err if !(Txn.sender == app_global_get('Owner'))
    app_global_put('Sale Price', 0)
    approve
  end

  teal def bid
    payment = Gtxn[1]
    app_call = Gtxn[0]
    highest_bidder = app_global_get('Highest Bidder')
    highest_bid = app_global_get('Highest Bid')

    err if !(Global.latest_timestamp < app_global_get('Auction End'))
    err if !(payment.amount > highest_bid)
    err if !(app_call.sender == payment.sender)

    if highest_bidder != ''
      pay(highest_bidder, highest_bid)
    end

    app_global_put('Highest Bid', payment.amount)
    app_global_put('Highest Bidder', payment.sender)
    approve
  end

  def pay(receiver, amount)
    # use compile_block(binding) so we have access to receiver and amount
    compile_block(binding) do
      itxn_begin
      itxn_field 'TypeEnum', 1
      itxn_field 'Receiver', receiver
      itxn_field 'Amount', amount - @fee
      itxn_submit
    end
  end

  teal def end_auction
    highest_bid = app_global_get 'Highest Bid'
    royalty_percent = app_global_get 'Royalty Percent'
    royalty_amount = highest_bid * royalty_percent / 100
    royalty_address = app_global_get 'Royalty Address'
    owner = app_global_get 'Owner'

    err if !(Global.latest_timestamp > app_global_get('Auction End'))
    pay(royalty_address, royalty_amount)
    pay(owner, highest_bid - royalty_amount)
    app_global_put('Auction End', 0)
    app_global_put('Owner', app_global_get('Highest Bidder'))
    app_global_put('Highest Bidder', '')
    approve
  end

  teal def transfer
    receiver = Txna.application_args(1)

    err if !(app_global_get('TX Methods') & 1)
    err if !(Txn.sender == app_global_get('Owner'))
    app_global_put('Owner', receiver)
    approve
  end

  teal def buy
    royalty_payment = Gtxn[2]
    payment = Gtxn[1]
    royalty_amount = app_global_get('Sale Price') * app_global_get('Royalty Percent') / 100
    purchase_amount = app_global_get('Sale Price') - royalty_amount

    err if !(app_global_get('Sale Price') > 0)

    # Verify senders are all the same
    err if !(royalty_payment.sender == payment.sender)
    err if !(Txn.sender == payment.sender)

    # Verify receivers are correct
    err if !(royalty_payment.receiver == app_global_get('Royalty Address'))
    err if !(payment.receiver == app_global_get('Owner'))

    # Verify amounts are correct
    err if !(royalty_payment.amount == royalty_amount)
    err if !(payment.amount == purchase_amount)

    app_global_put('Owner', Txn.sender)
    app_global_put('Sale Price', 0)
    approve
  end

  def source
    if Txn.application_id == 0
      init
    elsif Txna.application_args(0) == 'start_auction'
      start_auction
    elsif Txna.application_args(0) == 'start_sale'
      start_sale
    elsif Txna.application_args(0) == 'end_sale'
      end_sale
    elsif Txna.application_args(0) == 'bid'
      bid
    elsif Txna.application_args(0) == 'end_auction'
      end_auction
    elsif Txna.application_args(0) == 'transfer'
      transfer
    elsif Txna.application_args(0) == 'buy'
      buy
    else
      err
    end
  end
end

approval = Approval.new
approval.compile_source
IO.write('example.teal', approval.teal )