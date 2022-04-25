# frozen_string_literal: true

require 'minitest/autorun'
require '../lib/tealrb'

class RawTealTests < Minitest::Test
  def compile_test(input, teal)
    contract = TEALrb::ContractV2.new
    contract.compile_string input

    assert_equal(teal, contract.teal.first)
  end

  def test_acct_params_get
    compile_test 'acct_params_get 0', 'acct_params_get 0'
  end

  def test_add
    compile_test 'add', '+'
  end

  def test_addw
    compile_test 'addw', 'addw'
  end

  def test_app_global_del
    compile_test 'app_global_del', 'app_global_del'
  end

  def test_app_global_get
    compile_test 'app_global_get', 'app_global_get'
  end

  def test_app_global_get_ex
    compile_test 'app_global_get_ex', 'app_global_get_ex'
  end

  def test_app_global_put
    compile_test 'app_global_put', 'app_global_put'
  end

  def test_app_local_del
    compile_test 'app_local_del', 'app_local_del'
  end

  def test_app_local_get
    compile_test 'app_local_get', 'app_local_get'
  end

  def test_app_local_get_ex
    compile_test 'app_local_get_ex', 'app_local_get_ex'
  end

  def test_app_local_put
    compile_test 'app_local_put', 'app_local_put'
  end

  def test_app_opted_in
    compile_test 'app_opted_in', 'app_opted_in'
  end

  def test_app_params_get
    compile_test 'app_params_get 0', 'app_params_get 0'
  end

  def test_arg
    compile_test 'arg 0', 'arg 0'
  end

  def test_args
    compile_test 'args', 'args'
  end

  def test_assert
    compile_test 'assert', 'assert'
  end

  def test_asset_holding_get
    compile_test 'asset_holding_get 0', 'asset_holding_get 0'
  end

  def test_asset_params_get
    compile_test 'asset_params_get 0', 'asset_params_get 0'
  end

  def test_b
    compile_test 'b :label', 'b label'
  end

  def test_balance
    compile_test 'balance', 'balance'
  end

  def test_big_endian_add
    compile_test 'big_endian_add', 'b+'
  end

  def test_big_endian_divide
    compile_test 'big_endian_divide', 'b/'
  end

  def test_big_endian_equal
    compile_test 'big_endian_equal', 'b=='
  end

  def test_big_endian_less
    compile_test 'big_endian_less', 'b<'
  end

  def test_big_endian_less_eq
    compile_test 'big_endian_less_eq', 'b<='
  end

  def test_big_endian_modulo
    compile_test 'big_endian_modulo', 'b%'
  end

  def test_big_endian_more
    compile_test 'big_endian_more', 'b>'
  end

  def test_big_endian_more_eq
    compile_test 'big_endian_more_eq', 'b>='
  end

  def test_big_endian_multiply
    compile_test 'big_endian_multiply', 'b*'
  end

  def test_big_endian_not_equal
    compile_test 'big_endian_not_equal', 'b!='
  end

  def test_big_endian_subtract
    compile_test 'big_endian_subtract', 'b-'
  end

  def test_bitlen
    compile_test 'bitlen', 'bitlen'
  end

  def test_bitwise_and
    compile_test 'bitwise_and', '&'
  end

  def test_bitwise_byte_invert
    compile_test 'bitwise_byte_invert', 'b~'
  end

  def test_bitwise_invert
    compile_test 'bitwise_invert', '~'
  end

  def test_bitwise_or
    compile_test 'bitwise_or', '|'
  end

  def test_bitwise_xor
    compile_test 'bitwise_xor', '^'
  end

  def test_bnz
    compile_test 'bnz :label', 'bnz label'
  end

  def test_bsqrt
    compile_test 'bsqrt', 'bsqrt'
  end

  def test_btoi
    compile_test 'btoi', 'btoi'
  end

  def test_byte
    compile_test 'byte "0"', 'byte "0"'
  end

  def test_bytec
    compile_test 'bytec 0', 'bytec 0'
  end

  def test_bytecblock
    compile_test 'bytecblock 0', 'bytecblock 0'
  end

  def test_bz
    compile_test 'bz :label', 'bz label'
  end

  def test_bzero
    compile_test 'bzero', 'bzero'
  end

  def test_callsub
    compile_test 'callsub :name', 'callsub name'
  end

  def test_concat
    compile_test 'concat', 'concat'
  end

  def test_cover
    compile_test 'cover 0', 'cover 0'
  end

  def test_dig
    compile_test 'dig 0', 'dig 0'
  end

  def test_divide
    compile_test 'divide', '/'
  end

  def test_divmodw
    compile_test 'divmodw', 'divmodw'
  end

  def test_divw
    compile_test 'divw', 'divw'
  end

  def test_dup
    compile_test 'dup', 'dup'
  end

  def test_dup2
    compile_test 'dup2', 'dup2'
  end

  def test_ecdsa_pk_decompress
    compile_test 'ecdsa_pk_decompress 0', 'ecdsa_pk_decompress 0'
  end

  def test_ecdsa_pk_recover
    compile_test 'ecdsa_pk_recover 0', 'ecdsa_pk_recover 0'
  end

  def test_ecdsa_verify
    compile_test 'ecdsa_verify 0', 'ecdsa_verify 0'
  end

  def test_ed25519verify
    compile_test 'ed25519verify', 'ed25519verify'
  end

  def test_equal
    compile_test 'equal', '=='
  end

  def test_exp
    compile_test 'exp', 'exp'
  end

  def test_expw
    compile_test 'expw', 'expw'
  end

  def test_extract
    compile_test 'extract 0, 1', 'extract 0 1'
  end

  def test_extract3
    compile_test 'extract3', 'extract3'
  end

  def test_extract_uint16
    compile_test 'extract_uint16', 'extract_uint16'
  end

  def test_extract_uint32
    compile_test 'extract_uint32', 'extract_uint32'
  end

  def test_extract_uint64
    compile_test 'extract_uint64', 'extract_uint64'
  end

  def test_gaid
    compile_test 'gaid 0', 'gaid 0'
  end

  def test_gaids
    compile_test 'gaids', 'gaids'
  end

  def test_getbit
    compile_test 'getbit', 'getbit'
  end

  def test_getbyte
    compile_test 'getbyte', 'getbyte'
  end

  def test_gitxn
    compile_test 'gitxn 0, 1', 'gitxn 0 1'
  end

  def test_gitxna
    compile_test 'gitxna 0, 1, 2', 'gitxna 0 1 2'
  end

  def test_gitxnas
    compile_test 'gitxnas 0, 1', 'gitxnas 0 1'
  end

  def test_gload
    compile_test 'gload 0, 1', 'gload 0 1'
  end

  def test_gloads
    compile_test 'gloads 0', 'gloads 0'
  end

  def test_gloadss
    compile_test 'gloadss', 'gloadss'
  end

  def test_global
    compile_test 'global 0', 'global 0'
  end

  def test_greater
    compile_test 'greater', '>'
  end

  def test_greater_eq
    compile_test 'greater_eq', '>='
  end

  def test_gtxn
    compile_test 'gtxn 0, 1', 'gtxn 0 1'
  end

  def test_gtxna
    compile_test 'gtxna 0, 1, 2', 'gtxna 0 1 2'
  end

  def test_gtxns
    compile_test 'gtxns 0', 'gtxns 0'
  end

  def test_gtxnsa
    compile_test 'gtxnsa 0, 1', 'gtxnsa 0 1'
  end

  def test_gtxnas
    compile_test 'gtxnas 0, 1', 'gtxnas 0 1'
  end

  def test_gtxnsas
    compile_test 'gtxnsas 0', 'gtxnsas 0'
  end

  def test_int
    compile_test 'int 0', 'int 0'
  end

  def test_intc
    compile_test 'intc 0', 'intc 0'
  end

  def test_intcblock
    compile_test 'intcblock 0, 1, 2, 3', 'intcblock 0 1 2 3'
  end

  def test_itob
    compile_test 'itob', 'itob'
  end

  def test_itxn_field
    compile_test 'itxn_field 0', 'itxn_field 0'
  end

  def test_itxna
    compile_test 'itxna 0, 1', 'itxna 0 1'
  end

  def test_itxnas
    compile_test 'itxnas 0', 'itxnas 0'
  end

  def test_keccak256
    compile_test 'keccak256', 'keccak256'
  end

  def test_len
    compile_test 'len', 'len'
  end

  def test_less
    compile_test 'less', '<'
  end

  def test_less_eq
    compile_test 'less_eq', '<='
  end

  def test_load
    compile_test 'load 0', 'load 0'
  end

  def test_loads
    compile_test 'loads', 'loads'
  end

  def test_log
    compile_test 'log', 'log'
  end

  def test_min_balance
    compile_test 'min_balance', 'min_balance'
  end

  def test_modulo
    compile_test 'modulo', '%'
  end

  def test_multiply
    compile_test 'multiply', '*'
  end

  def test_mulw
    compile_test 'mulw', 'mulw'
  end

  def test_zero?
    compile_test 'zero?', '!'
  end

  def test_not_equal
    compile_test 'not_equal', '!='
  end

  def test_padded_bitwise_and
    compile_test 'padded_bitwise_and', 'b&'
  end

  def test_padded_bitwise_or
    compile_test 'padded_bitwise_or', 'b|'
  end

  def test_padded_bitwise_xor
    compile_test 'padded_bitwise_xor', 'b^'
  end

  def test_pop
    compile_test 'pop', 'pop'
  end

  def test_pushbytes
    compile_test 'pushbytes "0"', 'pushbytes "0"'
  end

  def test_pushint
    compile_test 'pushint 0', 'pushint 0'
  end

  def test_select
    compile_test 'select', 'select'
  end

  def test_setbit
    compile_test 'setbit', 'setbit'
  end

  def test_setbyte
    compile_test 'setbyte', 'setbyte'
  end

  def test_sha256
    compile_test 'sha256', 'sha256'
  end

  def test_sha512_256
    compile_test 'sha512_256', 'sha512_256'
  end

  def test_shl
    compile_test 'shl', 'shl'
  end

  def test_shr
    compile_test 'shr', 'shr'
  end

  def test_sqrt
    compile_test 'sqrt', 'sqrt'
  end

  def test_store
    compile_test 'store 0', 'store 0'
  end

  def test_stores
    compile_test 'stores', 'stores'
  end

  def test_substring
    compile_test 'substring 0, 1', 'substring 0 1'
  end

  def test_substring3
    compile_test 'substring3', 'substring3'
  end

  def test_subtract
    compile_test 'subtract', '-'
  end

  def test_swap
    compile_test 'swap', 'swap'
  end

  def test_teal_return
    compile_test 'teal_return', 'return'
  end

  def test_txn
    compile_test 'txn 0', 'txn 0'
  end

  def test_txna
    compile_test 'txna 0, 1', 'txna 0 1'
  end

  def test_txnas
    compile_test 'txnas 0', 'txnas 0'
  end

  def test_uncover
    compile_test 'uncover 0', 'uncover 0'
  end

  def test_boolean_and
    compile_test 'boolean_and', '&&'
  end

  def test_boolean_or
    compile_test 'boolean_or', '||'
  end

  def test_label
    compile_test ':label', 'label:'
  end
end
