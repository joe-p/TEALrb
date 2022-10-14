# frozen_string_literal: true

require_relative '../../lib/tealrb'

class Approval < TEALrb::Contract
  def populate_global_state
    params = %i[total decimals default_frozen name unit_name url
                metadata_hash manager reserve freeze clawback creator]

    params.each do |param|
      key = "ASA #{param}"

      app_global_del(byte(key))
      Global[byte(key)] = @scratch[:asa].send(param)
    end
  end

  def main
    approve if Txn.application_id == 0
    assert Txn.on_completion == int('NoOp')

    $asa = Assets[0]
    assert Gtxns[Txn.group_index - 1].xfer_asset == $asa

    populate_global_state
  end
end

approval = Approval.new
approval.compile
File.write("#{__dir__}/meta_programming.teal", approval.teal_source)
