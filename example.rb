require_relative 'lib/teal'
require 'pry'

include TEALrb

approval = Compiler.new

approval.def 'init' do 
  compile_block do
    app_global_put('Royalty Address', Txna.application_args(0))
    app_global_put('Owner', Txn.sender)
    app_global_put('Highest Bidder', '')
    app_global_put('Metadata', Txna.application_args(2))

    app_global_put('Royalty Percent', btoi(Txna.application_args(1)))
    app_global_put('Auction End', 0)
    app_global_put('TX Methods', btoi(Txna.application_args(3)))
    app_global_put('Sale Price', 0)
    app_global_put('Highest Bid', 0)

    approve
  end
end

approval.def 'start_auction' do 
  vars.payment = Gtxn[1]
  vars.starting_price = btoi(Txna.application_args(1))
  vars.duration = btoi(Txna.application_args(2))

  compile_block do
    err if !(app_global_get('TX Methods') & 4)
    err if !(payment.receiver == Global.current_application_address)
    err if !(payment.amount == 100000)
    app_global_put('Auction End', Global.latest_timestamp + duration)
    app_global_put('Highest Bid', starting_price)

    approve
  end
end

approval.compile do
  if Txn.application_id == 0
    init
  elsif Txna.application_args(0) == 'start_auction'
    start_auction
  else
    err
  end
end

puts approval.teal