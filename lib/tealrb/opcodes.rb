# frozen_string_literal: true

# rubocop:disable Lint/UnusedMethodArgument

module TEALrb
  module Opcodes
    BINARY_OPCODE_METHOD_MAPPING = {
      '+': 'add',
      '-': 'subtract',
      '<': 'less',
      '>': 'greater',
      '<=': 'less_eq',
      '>=': 'greater_eq',
      '/': 'divide',
      '==': 'equal',
      '&': 'bitwise_and',
      '!=': 'not_equal',
      '*': 'multiply',
      '&&': 'boolean_and',
      '||': 'boolean_or',
      '%': 'modulo',
      '|': 'bitwise_or',
      '^': 'bitwise_xor',
      '~': 'bitwise_invert',
      'b+': 'big_endian_add',
      'b-': 'big_endian_subtract',
      'b/': 'big_endian_divide',
      'b*': 'big_endian_multiply',
      'b<': 'big_endian_less',
      'b>': 'big_endian_more',
      'b<=': 'big_endian_less_eq',
      'b>=': 'big_endian_more_eq',
      'b==': 'big_endian_equal',
      'b!=': 'big_endian_not_equal',
      'b%': 'big_endian_modulo',
      'b|': 'padded_bitwise_or',
      'b&': 'padded_bitwise_and',
      'b^': 'padded_bitwise_xor',
      'b~': 'bitwise_byte_invert'
    }.freeze

    UNARY_OPCODE_METHOD_MAPPING = {
      '!': 'zero?'
    }.freeze

    module TEALOpcodes
      def acct_params_get(field, account = nil)
        @contract.teal << "acct_params_get #{field}"
        @contract
      end

      def add(a = nil, b = nil)
        @contract.teal << '+'
        @contract
      end

      def addr(address)
        @contract.teal << "addr #{address}"
        @contract
      end

      def addw(a = nil, b = nil)
        @contract.teal << 'addw'
        @contract
      end

      def app_global_del(key = nil)
        @contract.teal << 'app_global_del'
        @contract
      end

      def app_global_get(key = nil)
        @contract.teal << 'app_global_get'
        @contract
      end

      def app_global_get_ex(app = nil, key = nil)
        @contract.teal << 'app_global_get_ex'
        @contract
      end

      def app_global_put(key = nil, value = nil)
        @contract.teal << 'app_global_put'
        @contract
      end

      def app_local_del(account = nil, key = nil)
        @contract.teal << 'app_local_del'
        @contract
      end

      def app_local_get(account = nil, key = nil)
        @contract.teal << 'app_local_get'
        @contract
      end

      def app_local_get_ex(account = nil, application = nil, key = nil)
        @contract.teal << 'app_local_get_ex'
        @contract
      end

      def app_local_put(account = nil, key = nil, value = nil)
        @contract.teal << 'app_local_put'
        @contract
      end

      def app_opted_in(account = nil, app = nil)
        @contract.teal << 'app_opted_in'
        @contract
      end

      def app_params_get(field, app_id = nil)
        @contract.teal << "app_params_get #{field}"
        @contract
      end

      def approve
        @contract.teal << 'int 1'
        @contract.teal << 'return'
        @contract
      end

      def arg(index)
        @contract.teal << "arg #{index}"
        @contract
      end

      def arg_0 # rubocop:disable Naming/VariableNumber
        @contract.teal << 'arg_0'
        @contract
      end

      def arg_1 # rubocop:disable Naming/VariableNumber
        @contract.teal << 'arg_1'
        @contract
      end

      def arg_2 # rubocop:disable Naming/VariableNumber
        @contract.teal << 'arg_2'
        @contract
      end

      def arg_3 # rubocop:disable Naming/VariableNumber
        @contract.teal << 'arg_3'
        @contract
      end

      def args(index = nil)
        @contract.teal << 'args'
        @contract
      end

      def assert(expr = nil)
        @contract.teal << 'assert'
        @contract
      end

      def asset_holding_get(field, account = nil, asset = nil)
        @contract.teal << "asset_holding_get #{field}"
        @contract
      end

      def asset_params_get(field, asset = nil)
        @contract.teal << "asset_params_get #{field}"
        @contract
      end

      def b(target)
        @contract.teal << "#{__method__} #{target}"
        @contract
      end

      def base32(input)
        @contract.teal << "byte base32(#{input})"
        @contract
      end

      def base64_decode(encoding, input = nil)
        @contract.teal << "base64_decode #{encoding}"
        @contract
      end

      def balance(account = nil)
        @contract.teal << 'balance'
        @contract
      end

      def big_endian_add(a = nil, b = nil)
        @contract.teal << 'b+'
        @contract
      end

      def big_endian_divide(a = nil, b = nil)
        @contract.teal << 'b/'
        @contract
      end

      def big_endian_equal(a = nil, b = nil)
        @contract.teal << 'b=='
        @contract
      end

      def big_endian_less(a = nil, b = nil)
        @contract.teal << 'b<'
        @contract
      end

      def big_endian_less_eq(a = nil, b = nil)
        @contract.teal << 'b<='
        @contract
      end

      def big_endian_modulo(a = nil, b = nil)
        @contract.teal << 'b%'
        @contract
      end

      def big_endian_more(a = nil, b = nil)
        @contract.teal << 'b>'
        @contract
      end

      def big_endian_more_eq(a = nil, b = nil)
        @contract.teal << 'b>='
        @contract
      end

      def big_endian_multiply(a = nil, b = nil)
        @contract.teal << 'b*'
        @contract
      end

      def big_endian_not_equal(a = nil, b = nil)
        @contract.teal << 'b!='
        @contract
      end

      def big_endian_subtract(a = nil, b = nil)
        @contract.teal << 'b-'
        @contract
      end

      def bitlen(input = nil)
        @contract.teal << 'bitlen'
        @contract
      end

      def bitwise_and(a = nil, b = nil)
        @contract.teal << '&'
        @contract
      end

      def bitwise_byte_invert(a = nil, b = nil)
        @contract.teal << 'b~'
        @contract
      end

      def bitwise_invert(a = nil, b = nil)
        @contract.teal << '~'
        @contract
      end

      def bitwise_or(a = nil, b = nil)
        @contract.teal << '|'
        @contract
      end

      def bitwise_xor(a = nil, b = nil)
        @contract.teal << '^'
        @contract
      end

      def bnz(target)
        @contract.teal << "#{__method__} #{target}"
        @contract
      end

      def box_create(name = nil, length = nil)
        @contract.teal << 'box_create'
        @contract
      end

      def box_extract(name = nil, offset = nil, length = nil)
        @contract.teal << 'box_extract'
        @contract
      end

      def box_replace(name = nil, offset = nil, value = nil)
        @contract.teal << 'box_replace'
        @contract
      end

      def box_del(name = nil)
        @contract.teal << 'box_del'
        @contract
      end

      def box_len(name = nil)
        @contract.teal << 'box_len'
        @contract
      end

      def box_get(name = nil)
        @contract.teal << 'box_get'
        @contract
      end

      def box_put(name = nil, value = nil)
        @contract.teal << 'box_put'
        @contract
      end

      def bsqrt(big_endian_uint = nil)
        @contract.teal << 'bsqrt'
        @contract
      end

      def btoi(bytes = nil)
        @contract.teal << 'btoi'
        @contract
      end

      def byte(string)
        @contract.teal << "byte \"#{string}\""
        @contract
      end

      def bytec(index)
        @contract.teal << "bytec #{index}"
        @contract
      end

      def bytec_0 # rubocop:disable Naming/VariableNumber
        @contract.teal << 'bytec_0'
        @contract
      end

      def bytec_1 # rubocop:disable Naming/VariableNumber
        @contract.teal << 'bytec_1'
        @contract
      end

      def bytec_2 # rubocop:disable Naming/VariableNumber
        @contract.teal << 'bytec_2'
        @contract
      end

      def bytec_3 # rubocop:disable Naming/VariableNumber
        @contract.teal << 'bytec_3'
        @contract
      end

      def bytecblock(*bytes)
        @contract.teal << "bytecblock #{bytes.join(' ')}"
        @contract
      end

      def bz(target)
        @contract.teal << "#{__method__} #{target}"
        @contract
      end

      def bzero(length = nil)
        @contract.teal << 'bzero'
        @contract
      end

      def callsub(name, *_args)
        @contract.teal << "callsub #{name}"
        @contract
      end

      def concat(a = nil, b = nil)
        @contract.teal << 'concat'
        @contract
      end

      def cover(count)
        @contract.teal << "cover #{count}"
        @contract
      end

      def dig(index)
        @contract.teal << "dig #{index}"
        @contract
      end

      def divide(a = nil, b = nil)
        @contract.teal << '/'
        @contract
      end

      def divmodw(a = nil, b = nil)
        @contract.teal << 'divmodw'
        @contract
      end

      def divw(a = nil, b = nil)
        @contract.teal << 'divw'
        @contract
      end

      def dup(expr = nil)
        @contract.teal << 'dup'
        @contract
      end

      def dup2(expr_a = nil, expr_b = nil)
        @contract.teal << 'dup2'
        @contract
      end

      def ecdsa_pk_decompress(index, input = nil)
        @contract.teal << "ecdsa_pk_decompress #{index}"
        @contract
      end

      def ecdsa_pk_recover(index, input = nil)
        @contract.teal << "ecdsa_pk_recover #{index}"
        @contract
      end

      def ecdsa_verify(index, input = nil)
        @contract.teal << "ecdsa_verify #{index}"
        @contract
      end

      def ed25519verify(input = nil)
        @contract.teal << 'ed25519verify'
        @contract
      end

      def ed25519verify_bare(input = nil)
        @contract.teal << 'ed25519verify_bare'
        @contract
      end

      def equal(a = nil, b = nil)
        @contract.teal << '=='
        @contract
      end

      def err
        @contract.teal << 'err'
        @contract
      end

      def exp(a = nil, b = nil)
        @contract.teal << 'exp'
        @contract
      end

      def expw(a = nil, b = nil)
        @contract.teal << 'expw'
        @contract
      end

      def extract(start, length, byte_array = nil)
        @contract.teal << "extract #{start} #{length}"
        @contract
      end

      def extract3(byte_array = nil, start = nil, exclusive_end = nil)
        @contract.teal << 'extract3'
        @contract
      end

      def extract_uint16(byte_array = nil, start = nil)
        @contract.teal << 'extract_uint16'
        @contract
      end

      def extract_uint32(byte_array = nil, start = nil)
        @contract.teal << 'extract_uint32'
        @contract
      end

      def extract_uint64(byte_array = nil, start = nil)
        @contract.teal << 'extract_uint64'
        @contract
      end

      def gaid(transaction_index)
        @contract.teal << "gaid #{transaction_index}"
        @contract
      end

      def gaids(transaction = nil)
        @contract.teal << 'gaids'
        @contract
      end

      def getbit(input = nil, bit_index = nil)
        @contract.teal << 'getbit'
        @contract
      end

      def getbyte(input = nil, byte_index = nil)
        @contract.teal << 'getbyte'
        @contract
      end

      def gitxn(transaction_index, field)
        @contract.teal << "gitxn #{transaction_index} #{field}"
        @contract
      end

      def gitxna(transaction_index, field, index)
        @contract.teal << "gitxna #{transaction_index} #{field} #{index}"
        @contract
      end

      def gitxnas(transaction_index, field, index = nil)
        @contract.teal << "gitxnas #{transaction_index} #{field}"
        @contract
      end

      def gload(transaction_index, index)
        @contract.teal << "gload #{transaction_index} #{index}"
        @contract
      end

      def gloads(index, transaction_index = nil)
        @contract.teal << "gloads #{index}"
        @contract
      end

      def gloadss(transaction = nil, index = nil)
        @contract.teal << 'gloadss'
        @contract
      end

      def global(field)
        @contract.teal << "global #{field}"
        @contract
      end

      def greater(a = nil, b = nil)
        @contract.teal << '>'
        @contract
      end

      def greater_eq(a = nil, b = nil)
        @contract.teal << '>='
        @contract
      end

      def gtxn(index, field)
        @contract.teal << "gtxn #{index} #{field}"
        @contract
      end

      def gtxna(transaction_index, field, index)
        @contract.teal << "gtxna #{transaction_index} #{field} #{index}"
        @contract
      end

      def gtxns(field, transaction_index = nil)
        @contract.teal << "gtxns #{field}"
        @contract
      end

      def gtxnsa(field, index, transaction_index = nil)
        @contract.teal << "gtxnsa #{field} #{index}"
        @contract
      end

      def gtxnas(transaction_index, field, index = nil)
        @contract.teal << "gtxnas #{transaction_index} #{field}"
        @contract
      end

      def gtxnsas(field, transaction_index = nil, index = nil)
        @contract.teal << "gtxnsas #{field}"
        @contract
      end

      def int(integer)
        @contract.teal << "int #{integer}"
        @contract
      end

      def intc(index)
        @contract.teal << "intc #{index}"
        @contract
      end

      def intc_0 # rubocop:disable Naming/VariableNumber
        @contract.teal << 'intc_0'
        @contract
      end

      def intc_1 # rubocop:disable Naming/VariableNumber
        @contract.teal << 'intc_1'
        @contract
      end

      def intc_2 # rubocop:disable Naming/VariableNumber
        @contract.teal << 'intc_2'
        @contract
      end

      def intc_3 # rubocop:disable Naming/VariableNumber
        @contract.teal << 'intc_3'
        @contract
      end

      def intcblock(*ints)
        @contract.teal << "intcblock #{ints.join(' ')}"
        @contract
      end

      def itob(bytes = nil)
        @contract.teal << 'itob'
        @contract
      end

      def itxn_begin
        @contract.teal << 'itxn_begin'
        @contract
      end

      def itxn_field(field, value = nil)
        @contract.teal << "itxn_field #{field}"
        @contract
      end

      def itxn_next
        @contract.teal << 'itxn_next'
        @contract
      end

      def itxn_submit
        @contract.teal << 'itxn_submit'
        @contract
      end

      def itxna(field, index)
        @contract.teal << "itxna #{field} #{index}"
        @contract
      end

      def itxnas(field, index = nil)
        @contract.teal << "itxnas #{field}"
        @contract
      end

      def json_ref(type, object = nil, key = nil)
        @contract.teal << "json_ref #{type}"
        @contract
      end

      def keccak256(input = nil)
        @contract.teal << 'keccak256'
        @contract
      end

      def label(label_name)
        @contract.teal << "#{label_name}:"
        @contract
      end

      def len(input = nil)
        @contract.teal << 'len'
        @contract
      end

      def less(a = nil, b = nil)
        @contract.teal << '<'
        @contract
      end

      def less_eq(a = nil, b = nil)
        @contract.teal << '<='
        @contract
      end

      def load(index)
        @contract.teal << "load #{index}"
        @contract
      end

      def loads(index = nil)
        @contract.teal << 'loads'
        @contract
      end

      def log(byte_array = nil)
        @contract.teal << 'log'
        @contract
      end

      def method_signature(signature)
        @contract.teal << %(method "#{signature}")
        @contract
      end

      def min_balance(account = nil)
        @contract.teal << 'min_balance'
        @contract
      end

      def modulo(a = nil, b = nil)
        @contract.teal << '%'
        @contract
      end

      def multiply(a = nil, b = nil)
        @contract.teal << '*'
        @contract
      end

      def mulw(a = nil, b = nil)
        @contract.teal << 'mulw'
        @contract
      end

      def zero?(expr = nil)
        @contract.teal << '!'
        @contract
      end

      def not_equal(a = nil, b = nil)
        @contract.teal << '!='
        @contract
      end

      def padded_bitwise_and(a = nil, b = nil)
        @contract.teal << 'b&'
        @contract
      end

      def padded_bitwise_or(a = nil, b = nil)
        @contract.teal << 'b|'
        @contract
      end

      def padded_bitwise_xor(a = nil, b = nil)
        @contract.teal << 'b^'
        @contract
      end

      def pop(expr = nil)
        @contract.teal << 'pop'
        @contract
      end

      def pushbytes(string)
        @contract.teal << "pushbytes \"#{string}\""
        @contract
      end

      def pushint(integer)
        @contract.teal << "pushint #{integer}"
        @contract
      end

      def replace(a = nil, b = nil, c = nil)
        @contract.teal << 'replace'
        @contract
      end

      def replace2(start, a = nil, b = nil)
        @contract.teal << "replace2 #{start}"
        @contract
      end

      def retsub
        @contract.teal << 'retsub'
        @contract
      end

      def select(expr_a = nil, expr_b = nil, expr_c = nil)
        @contract.teal << 'select'
        @contract
      end

      def setbit(input = nil, bit_index = nil, value = nil)
        @contract.teal << 'setbit'
        @contract
      end

      def setbyte(byte_array = nil, byte_index = nil, value = nil)
        @contract.teal << 'setbyte'
        @contract
      end

      def sha256(input = nil)
        @contract.teal << 'sha256'
        @contract
      end

      # rubocop:disable Naming/VariableNumber
      def sha3_256(input = nil)
        @contract.teal << 'sha3_256'
        @contract
      end

      def sha512_256(input = nil)
        @contract.teal << 'sha512_256'
        @contract
      end

      # rubocop:enable Naming/VariableNumber

      def shl(a = nil, b = nil)
        @contract.teal << 'shl'
        @contract
      end

      def shr(a = nil, b = nil)
        @contract.teal << 'shr'
        @contract
      end

      def sqrt(integer = nil)
        @contract.teal << 'sqrt'
        @contract
      end

      def store(index, value = nil)
        @contract.teal << "store #{index}"
        @contract
      end

      def stores(index = nil, value = nil)
        @contract.teal << 'stores'
        @contract
      end

      def substring(start, exclusive_end, byte_array = nil)
        @contract.teal << "substring #{start} #{exclusive_end}"
        @contract
      end

      def substring3(byte_array = nil, start = nil, exclusive_end = nil)
        @contract.teal << 'substring3'
        @contract
      end

      def subtract(a = nil, b = nil)
        @contract.teal << '-'
        @contract
      end

      def swap(expr_a = nil, expr_b = nil)
        @contract.teal << 'swap'
        @contract
      end

      def teal_return(expr = nil)
        @contract.teal << 'return'
        @contract
      end

      def txn(field)
        @contract.teal << "txn #{field}"
        @contract
      end

      def txna(field, index)
        @contract.teal << "txna #{field} #{index}"
        @contract
      end

      def txnas(field, index = nil)
        @contract.teal << "txnas #{field}"
        @contract
      end

      def uncover(count)
        @contract.teal << "uncover #{count}"
        @contract
      end

      def vrf_verify(standard, message = nil, proof = nil, public_key = nil)
        @contract.teal << "vrf_verify #{standard}"
        @contract
      end

      def boolean_and(a = nil, b = nil)
        @contract.teal << '&&'
        @contract
      end

      def boolean_or(a = nil, b = nil)
        @contract.teal << '||'
        @contract
      end

      def pushints(*ints)
        @contract.teal << "pushints #{ints.join(' ')}"
        @contract
      end

      def pushbytess(*bytes)
        @contract.teal << "pushbytes #{bytes.map { "\"#{_1}\"" }.join(' ')}"
        @contract
      end

      def proto(num_args, num_return)
        @contract.teal << "proto #{num_args} #{num_return}"
        @contract
      end

      def frame_dig(n)
        @contract.teal << "frame_dig #{n}"
        @contract
      end

      def frame_bury(n)
        @contract.teal << "frame_bury #{n}"
        @contract
      end

      def switch(*labels)
        @contract.teal << "switch #{labels.join(' ')}"
        @contract
      end

      def match(*labels)
        @contract.teal << "match #{labels.join(' ')}"
        @contract
      end

      def popn(n)
        @contract.teal << "popn #{n}"
        @contract
      end

      def dupn(n)
        @contract.teal << "dupn #{n}"
        @contract
      end

      def bury(n)
        @contract.teal << "bury #{n}"
        @contract
      end
    end
  end
end

# rubocop:enable Lint/UnusedMethodArgument
