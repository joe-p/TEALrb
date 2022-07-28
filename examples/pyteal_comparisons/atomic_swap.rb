# frozen_string_literal: true

require_relative '../../lib/tealrb'

class AtomicSwap < TEALrb::Contract
  alias tmpl_hash_fn sha256

  def main
    alice = addr '6ZHGHH5Z5CTPCF5WCESXMGRSVK7QJETR63M3NY5FJCUYDHO57VTCMJOBGY'
    bob = addr '7Z5PWO2C6LFNQFGHWKSK5H47IQP5OJW2M3HA2QPXTY3WTNP5NU2MHBW27M'
    secret = base32 '2323232323232323'
    timeout = 3000

    tmpl_seller = alice
    tmpl_buyer = bob
    tmpl_fee = 1000
    tmpl_secret = secret
    tmpl_timeout = timeout

    fee_cond = Txn.fee < tmpl_fee
    safety_cond = Txn.type_enum == TxnType.pay && \
                  Txn.close_remainder_to == Global.zero_address && \
                  Txn.rekey_to == Global.zero_address

    recv_cond = Txn.receiver == tmpl_seller && tmpl_hash_fn(Txn.arg(0)) == tmpl_secret

    esc_cond = Txn.receiver == tmpl_buyer && Txn.first_valid > tmpl_timeout

    teal_return(fee_cond && safety_cond && (recv_cond || esc_cond))
  end
end

contract = AtomicSwap.new
contract.compile
File.write("#{__dir__}/atomic_swap_tealrb.teal", contract.teal.join("\n"))
