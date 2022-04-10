require_relative 'lib/teal'
require 'pry'

include TEALrb

approval = Compiler.new

=begin
    royalty_addr = ARGS[0]
    royalty_percent = Btoi(ARGS[1])
    metadata = ARGS[2]
    tx_methods = Btoi(ARGS[3]) # see comment on TX_METHODS for explanation

    return Seq(
        # Set global bytes
        set(ROYALTY_ADDR, royalty_addr), #b1
        set(OWNER, Txn.sender()), #b2
        set(HIGHEST_BIDDER, ""), #b3
        set(METADATA, metadata), #b4
        
        # Set global ints
        set(ROYALTY_PERCENT, royalty_percent), #i1
        set(AUCTION_END, Int(0)), #i2
        set(TX_METHODS, tx_methods), #i3
        set(SALE_PRICE, Int(0)), # i4
        set(HIGHEST_BID, Int(0)), # i5

        Approve()
=end

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