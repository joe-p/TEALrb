require_relative 'lib/teal'
require 'pry'

include TEALrb

approval = Compiler.new

approval.def 'init' do 
  vars.royalty_addr = Txna.application_args(0)
  vars.royalty_percent = btoi(Txna.application_args(1))
  vars.metadata = Txna.application_args(2)
  vars.tx_methods = btoi(Txna.application_args(3))

  compile_block do
    app_global_put('Royalty Address', royalty_addr)
    app_global_put('Owner', Txn.sender)
    app_global_put('Highest Bidder', '')
    app_global_put('Metadata', metadata)

    app_global_put('Royalty Percent', royalty_percent)
    app_global_put('Auction End', 0)
    app_global_put('TX Methods', tx_methods)
    app_global_put('Sale Price', 0)
    app_global_put('Highest Bid', 0)

    approve
  end
end

approval.compile do
  if Txn.application_id == 0
    init
  end
end

puts approval.teal