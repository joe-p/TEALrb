# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'

class RawTealTests < Minitest::Test
  include TestMethods

  def test_acct_params_get
    compile_test_last 'acct_params_get 0', 'acct_params_get 0'
  end

  def test_add
    compile_test_last 'add', '+'
  end

  def test_addw
    compile_test_last 'addw', 'addw'
  end

  def test_app_global_del
    compile_test_last 'app_global_del', 'app_global_del'
  end

  def test_app_global_get
    compile_test_last 'app_global_get', 'app_global_get'
  end

  def test_app_global_get_ex
    compile_test_last 'app_global_get_ex', 'app_global_get_ex'
  end

  def test_app_global_put
    compile_test_last 'app_global_put', 'app_global_put'
  end

  def test_app_local_del
    compile_test_last 'app_local_del', 'app_local_del'
  end

  def test_app_local_get
    compile_test_last 'app_local_get', 'app_local_get'
  end

  def test_app_local_get_ex
    compile_test_last 'app_local_get_ex', 'app_local_get_ex'
  end

  def test_app_local_put
    compile_test_last 'app_local_put', 'app_local_put'
  end

  def test_app_opted_in
    compile_test_last 'app_opted_in', 'app_opted_in'
  end

  def test_app_params_get
    compile_test_last 'app_params_get 0', 'app_params_get 0'
  end

  def test_arg
    compile_test_last 'arg 0', 'arg 0'
  end

  def test_args
    compile_test_last 'args', 'args'
  end

  def test_assert
    compile_test_last 'assert', 'assert'
  end

  def test_asset_holding_get
    compile_test_last 'asset_holding_get 0', 'asset_holding_get 0'
  end

  def test_asset_params_get
    compile_test_last 'asset_params_get 0', 'asset_params_get 0'
  end

  def test_b
    compile_test_last 'b :label', 'b label'
  end

  def test_balance
    compile_test_last 'balance', 'balance'
  end

  def test_big_endian_add
    compile_test_last 'big_endian_add', 'b+'
  end

  def test_big_endian_divide
    compile_test_last 'big_endian_divide', 'b/'
  end

  def test_big_endian_equal
    compile_test_last 'big_endian_equal', 'b=='
  end

  def test_big_endian_less
    compile_test_last 'big_endian_less', 'b<'
  end

  def test_big_endian_less_eq
    compile_test_last 'big_endian_less_eq', 'b<='
  end

  def test_big_endian_modulo
    compile_test_last 'big_endian_modulo', 'b%'
  end

  def test_big_endian_more
    compile_test_last 'big_endian_more', 'b>'
  end

  def test_big_endian_more_eq
    compile_test_last 'big_endian_more_eq', 'b>='
  end

  def test_big_endian_multiply
    compile_test_last 'big_endian_multiply', 'b*'
  end

  def test_big_endian_not_equal
    compile_test_last 'big_endian_not_equal', 'b!='
  end

  def test_big_endian_subtract
    compile_test_last 'big_endian_subtract', 'b-'
  end

  def test_bitlen
    compile_test_last 'bitlen', 'bitlen'
  end

  def test_bitwise_and
    compile_test_last 'bitwise_and', '&'
  end

  def test_bitwise_byte_invert
    compile_test_last 'bitwise_byte_invert', 'b~'
  end

  def test_bitwise_invert
    compile_test_last 'bitwise_invert', '~'
  end

  def test_bitwise_or
    compile_test_last 'bitwise_or', '|'
  end

  def test_bitwise_xor
    compile_test_last 'bitwise_xor', '^'
  end

  def test_bnz
    compile_test_last 'bnz :label', 'bnz label'
  end

  def test_bsqrt
    compile_test_last 'bsqrt', 'bsqrt'
  end

  def test_btoi
    compile_test_last 'btoi', 'btoi'
  end

  def test_byte
    compile_test_last 'byte "0"', 'byte "0"'
  end

  def test_bytec
    compile_test_last 'bytec 0', 'bytec 0'
  end

  def test_bytecblock
    compile_test_last 'bytecblock 0', 'bytecblock 0'
  end

  def test_bz
    compile_test_last 'bz :label', 'bz label'
  end

  def test_bzero
    compile_test_last 'bzero', 'bzero'
  end

  def test_callsub
    compile_test_last 'callsub :name', 'callsub name'
  end

  def test_concat
    compile_test_last 'concat', 'concat'
  end

  def test_cover
    compile_test_last 'cover 0', 'cover 0'
  end

  def test_dig
    compile_test_last 'dig 0', 'dig 0'
  end

  def test_divide
    compile_test_last 'divide', '/'
  end

  def test_divmodw
    compile_test_last 'divmodw', 'divmodw'
  end

  def test_divw
    compile_test_last 'divw', 'divw'
  end

  def test_dup
    compile_test_last 'dup', 'dup'
  end

  def test_dup2
    compile_test_last 'dup2', 'dup2'
  end

  def test_ecdsa_pk_decompress
    compile_test_last 'ecdsa_pk_decompress 0', 'ecdsa_pk_decompress 0'
  end

  def test_ecdsa_pk_recover
    compile_test_last 'ecdsa_pk_recover 0', 'ecdsa_pk_recover 0'
  end

  def test_ecdsa_verify
    compile_test_last 'ecdsa_verify 0', 'ecdsa_verify 0'
  end

  def test_ed25519verify
    compile_test_last 'ed25519verify', 'ed25519verify'
  end

  def test_equal
    compile_test_last 'equal', '=='
  end

  def test_exp
    compile_test_last 'exp', 'exp'
  end

  def test_expw
    compile_test_last 'expw', 'expw'
  end

  def test_extract
    compile_test_last 'extract 0, 1', 'extract 0 1'
  end

  def test_extract3
    compile_test_last 'extract3', 'extract3'
  end

  def test_extract_uint16
    compile_test_last 'extract_uint16', 'extract_uint16'
  end

  def test_extract_uint32
    compile_test_last 'extract_uint32', 'extract_uint32'
  end

  def test_extract_uint64
    compile_test_last 'extract_uint64', 'extract_uint64'
  end

  def test_gaid
    compile_test_last 'gaid 0', 'gaid 0'
  end

  def test_gaids
    compile_test_last 'gaids', 'gaids'
  end

  def test_getbit
    compile_test_last 'getbit', 'getbit'
  end

  def test_getbyte
    compile_test_last 'getbyte', 'getbyte'
  end

  def test_gitxn
    compile_test_last 'gitxn 0, 1', 'gitxn 0 1'
  end

  def test_gitxna
    compile_test_last 'gitxna 0, 1, 2', 'gitxna 0 1 2'
  end

  def test_gitxnas
    compile_test_last 'gitxnas 0, 1', 'gitxnas 0 1'
  end

  def test_gload
    compile_test_last 'gload 0, 1', 'gload 0 1'
  end

  def test_gloads
    compile_test_last 'gloads 0', 'gloads 0'
  end

  def test_gloadss
    compile_test_last 'gloadss', 'gloadss'
  end

  def test_global
    compile_test_last 'global 0', 'global 0'
  end

  def test_greater
    compile_test_last 'greater', '>'
  end

  def test_greater_eq
    compile_test_last 'greater_eq', '>='
  end

  def test_gtxn
    compile_test_last 'gtxn 0, 1', 'gtxn 0 1'
  end

  def test_gtxna
    compile_test_last 'gtxna 0, 1, 2', 'gtxna 0 1 2'
  end

  def test_gtxns
    compile_test_last 'gtxns 0', 'gtxns 0'
  end

  def test_gtxnsa
    compile_test_last 'gtxnsa 0, 1', 'gtxnsa 0 1'
  end

  def test_gtxnas
    compile_test_last 'gtxnas 0, 1', 'gtxnas 0 1'
  end

  def test_gtxnsas
    compile_test_last 'gtxnsas 0', 'gtxnsas 0'
  end

  def test_int
    compile_test_last 'int 0', 'int 0'
  end

  def test_intc
    compile_test_last 'intc 0', 'intc 0'
  end

  def test_intcblock
    compile_test_last 'intcblock 0, 1, 2, 3', 'intcblock 0 1 2 3'
  end

  def test_itob
    compile_test_last 'itob', 'itob'
  end

  def test_itxn_field
    compile_test_last 'itxn_field 0', 'itxn_field 0'
  end

  def test_itxna
    compile_test_last 'itxna 0, 1', 'itxna 0 1'
  end

  def test_itxnas
    compile_test_last 'itxnas 0', 'itxnas 0'
  end

  def test_keccak256
    compile_test_last 'keccak256', 'keccak256'
  end

  def test_len
    compile_test_last 'len', 'len'
  end

  def test_less
    compile_test_last 'less', '<'
  end

  def test_less_eq
    compile_test_last 'less_eq', '<='
  end

  def test_load
    compile_test_last 'load 0', 'load 0'
  end

  def test_loads
    compile_test_last 'loads', 'loads'
  end

  def test_log
    compile_test_last 'log', 'log'
  end

  def test_min_balance
    compile_test_last 'min_balance', 'min_balance'
  end

  def test_modulo
    compile_test_last 'modulo', '%'
  end

  def test_multiply
    compile_test_last 'multiply', '*'
  end

  def test_mulw
    compile_test_last 'mulw', 'mulw'
  end

  def test_zero?
    compile_test_last 'zero?', '!'
  end

  def test_not_equal
    compile_test_last 'not_equal', '!='
  end

  def test_padded_bitwise_and
    compile_test_last 'padded_bitwise_and', 'b&'
  end

  def test_padded_bitwise_or
    compile_test_last 'padded_bitwise_or', 'b|'
  end

  def test_padded_bitwise_xor
    compile_test_last 'padded_bitwise_xor', 'b^'
  end

  def test_pop
    compile_test_last 'pop', 'pop'
  end

  def test_pushbytes
    compile_test_last 'pushbytes "0"', 'pushbytes "0"'
  end

  def test_pushint
    compile_test_last 'pushint 0', 'pushint 0'
  end

  def test_select
    compile_test_last 'select', 'select'
  end

  def test_setbit
    compile_test_last 'setbit', 'setbit'
  end

  def test_setbyte
    compile_test_last 'setbyte', 'setbyte'
  end

  def test_sha256
    compile_test_last 'sha256', 'sha256'
  end

  def test_sha512_256 # rubocop:disable Naming/VariableNumber
    compile_test_last 'sha512_256', 'sha512_256'
  end

  def test_shl
    compile_test_last 'shl', 'shl'
  end

  def test_shr
    compile_test_last 'shr', 'shr'
  end

  def test_sqrt
    compile_test_last 'sqrt', 'sqrt'
  end

  def test_store
    compile_test_last 'store 0', 'store 0'
  end

  def test_stores
    compile_test_last 'stores', 'stores'
  end

  def test_substring
    compile_test_last 'substring 0, 1', 'substring 0 1'
  end

  def test_substring3
    compile_test_last 'substring3', 'substring3'
  end

  def test_subtract
    compile_test_last 'subtract', '-'
  end

  def test_swap
    compile_test_last 'swap', 'swap'
  end

  def test_teal_return
    compile_test_last 'teal_return', 'return'
  end

  def test_txn
    compile_test_last 'txn 0', 'txn 0'
  end

  def test_txna
    compile_test_last 'txna 0, 1', 'txna 0 1'
  end

  def test_txnas
    compile_test_last 'txnas 0', 'txnas 0'
  end

  def test_uncover
    compile_test_last 'uncover 0', 'uncover 0'
  end

  def test_boolean_and
    compile_test_last 'boolean_and', '&&'
  end

  def test_boolean_or
    compile_test_last 'boolean_or', '||'
  end

  def test_label
    compile_test_last ':label', 'label:'
  end

  {
    'pushints 1, 2, 3' => 'pushints 1 2 3',
    'pushbytess "a", "b", "c"' => 'pushbytes "a" "b" "c"',
    'proto 1, 2' => 'proto 1 2',
    'frame_dig 1' => 'frame_dig 1',
    'frame_bury 1' => 'frame_bury 1',
    'switch :a, :b, :c' => 'switch a b c',
    'match :a, :b, :c' => 'match a b c',
    'popn 1' => 'popn 1',
    'dupn 1' => 'dupn 1',
    'bury 1' => 'bury 1'
  }.each do |input, teal|
    define_method("test_#{input.split.first}") do
      compile_test_last(input, teal)
    end
  end
end
