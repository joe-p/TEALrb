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
  vars.price = btoi Txna.application_args(0)

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

approval.compile do
  if Txn.application_id == 0
    init
  elsif Txna.application_args(0) == 'start_auction'
    start_auction
  elsif Txna.application_args(0) == 'start_sale'
    start_sale
  elsif Txna.application_args(0) == 'end_sale'
    end_sale
  else
    err
  end
end

puts approval.teal