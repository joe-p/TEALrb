# frozen_string_literal: true

require_relative '../../lib/tealrb'

class DemoContract < TEALrb::Contract
  def main
    int(1).add int(1)
  end
end

approval = DemoContract.new
File.write("#{__dir__}/future.teal", approval.formatted_teal)
File.write("#{__dir__}/future.json", JSON.pretty_generate(approval.abi_hash))
puts approval.formatted_teal
