require_relative 'lib/teal'
require 'pry'

include TEALrb

approval = Compiler.new

approval.def 'init' do 
  vars.royalty_address = Txna.application_args(0)
  vars.royalty_percent = btoi Txna.application_args(1)
  vars.metadata = Txna.application_args(2)
  vars.tx_methods = btoi Txna.application_args(3)

  compile do
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
end

approval.def 'start_auction' do 
  vars.payment = Gtxn[1]
  vars.starting_price = btoi(Txna.application_args(1))
  vars.duration = btoi(Txna.application_args(2))

  compile do
    err if !(app_global_get('TX Methods') & 4)
    err if !(payment.receiver == Global.current_application_address)
    err if !(payment.amount == 100000)
    app_global_put('Auction End', Global.latest_timestamp + duration)
    app_global_put('Highest Bid', starting_price)

    approve
  end
end

approval.def 'start_sale' do 
  vars.price = btoi Txna.application_args(1)

  compile do
    err if !(app_global_get('TX Methods') & 2)
    err if !(Txn.sender == app_global_get('Owner'))
    app_global_put('Sale Price', price)
    approve
  end
end

approval.def 'end_sale' do 
  vars.price = btoi Txna.application_args(0)

  compile do
    err if !(Txn.sender == app_global_get('Owner'))
    app_global_put('Sale Price', 0)
    approve
  end
end

approval.def 'bid' do
  vars.payment = Gtxn[1]
  vars.app_call = Gtxn[0]
  vars.highest_bidder = app_global_get('Highest Bidder')
  vars.highest_bid = app_global_get('Highest Bid')

  compile do
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
end

approval.vars.fee = 1000

approval.def 'pay' do |receiever, amount|
  vars.receiever = receiever
  vars.amount = amount

  compile do
    itxn_begin
    itxn_field 'TypeEnum', 1
    itxn_field 'Receiver', receiever
    itxn_field 'Amount', amount - fee
    itxn_submit
  end
end

approval.main do
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
  else
    err
  end
end

puts approval.teal