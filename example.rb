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


approval.def 'royalty_addr' do
  approval.vars.royalty_addr = Txna.application_args(0)
end

approval.def 'init' do 
  app_global_put('Royalty Address', approval.vars.royalty_addr)
end

approval.compile do
  if Txn.application_id == 1
    init()
  end
end

puts approval.teal