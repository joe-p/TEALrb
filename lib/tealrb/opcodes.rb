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
        TEAL.instance << "acct_params_get #{field}"
      end

      def add(a = nil, b = nil)
        TEAL.instance << '+'
      end

      def addr(address)
        TEAL.instance << "addr #{address}"
      end

      def addw(a = nil, b = nil)
        TEAL.instance << 'addw'
      end

      def app_global_del(key = nil)
        TEAL.instance << 'app_global_del'
      end

      def app_global_get(key = nil)
        TEAL.instance << 'app_global_get'
      end

      def app_global_get_ex(app = nil, key = nil)
        TEAL.instance << 'app_global_get_ex'
      end

      def app_global_put(key = nil, value = nil)
        TEAL.instance << 'app_global_put'
      end

      def app_local_del(account = nil, key = nil)
        TEAL.instance << 'app_local_del'
      end

      def app_local_get(account = nil, key = nil)
        TEAL.instance << 'app_local_get'
      end

      def app_local_get_ex(account = nil, application = nil, key = nil)
        TEAL.instance << 'app_local_get_ex'
      end

      def app_local_put(account = nil, key = nil, value = nil)
        TEAL.instance << 'app_local_put'
      end

      def app_opted_in(account = nil, app = nil)
        TEAL.instance << 'app_opted_in'
      end

      def app_params_get(field, app_id = nil)
        TEAL.instance << "app_params_get #{field}"
      end

      def approve
        TEAL.instance << 'int 1'
        TEAL.instance << 'return'
      end

      def arg(index)
        TEAL.instance << "arg #{index}"
      end

      def arg_0 # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'arg_0'
      end

      def arg_1 # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'arg_1'
      end

      def arg_2 # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'arg_2'
      end

      def arg_3 # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'arg_3'
      end

      def args(index = nil)
        TEAL.instance << 'args'
      end

      def assert(expr = nil)
        TEAL.instance << 'assert'
      end

      def asset_holding_get(field, account = nil, asset = nil)
        TEAL.instance << "asset_holding_get #{field}"
      end

      def asset_params_get(field, asset = nil)
        TEAL.instance << "asset_params_get #{field}"
      end

      def b(target)
        TEAL.instance << "#{__method__} #{target}"
      end

      def base32(input)
        TEAL.instance << "byte base32(#{input})"
      end

      def base64_decode(encoding, input = nil)
        TEAL.instance << "base64_decode #{encoding}"
      end

      def balance(account = nil)
        TEAL.instance << 'balance'
      end

      def big_endian_add(a = nil, b = nil)
        TEAL.instance << 'b+'
      end

      def big_endian_divide(a = nil, b = nil)
        TEAL.instance << 'b/'
      end

      def big_endian_equal(a = nil, b = nil)
        TEAL.instance << 'b=='
      end

      def big_endian_less(a = nil, b = nil)
        TEAL.instance << 'b<'
      end

      def big_endian_less_eq(a = nil, b = nil)
        TEAL.instance << 'b<='
      end

      def big_endian_modulo(a = nil, b = nil)
        TEAL.instance << 'b%'
      end

      def big_endian_more(a = nil, b = nil)
        TEAL.instance << 'b>'
      end

      def big_endian_more_eq(a = nil, b = nil)
        TEAL.instance << 'b>='
      end

      def big_endian_multiply(a = nil, b = nil)
        TEAL.instance << 'b*'
      end

      def big_endian_not_equal(a = nil, b = nil)
        TEAL.instance << 'b!='
      end

      def big_endian_subtract(a = nil, b = nil)
        TEAL.instance << 'b-'
      end

      def bitlen(input = nil)
        TEAL.instance << 'bitlen'
      end

      def bitwise_and(a = nil, b = nil)
        TEAL.instance << '&'
      end

      def bitwise_byte_invert(a = nil, b = nil)
        TEAL.instance << 'b~'
      end

      def bitwise_invert(a = nil, b = nil)
        TEAL.instance << '~'
      end

      def bitwise_or(a = nil, b = nil)
        TEAL.instance << '|'
      end

      def bitwise_xor(a = nil, b = nil)
        TEAL.instance << '^'
      end

      def bnz(target)
        TEAL.instance << "#{__method__} #{target}"
      end

      def box_create(name = nil, length = nil)
        TEAL.instance << 'box_create'
      end

      def box_extract(name = nil, offset = nil, length = nil)
        TEAL.instance << 'box_extract'
      end

      def box_replace(name = nil, offset = nil, value = nil)
        TEAL.instance << 'box_replace'
      end

      def box_del(name = nil)
        TEAL.instance << 'box_del'
      end

      def box_len(name = nil)
        TEAL.instance << 'box_len'
      end

      def box_get(name = nil)
        TEAL.instance << 'box_get'
      end

      def box_put(name = nil, value = nil)
        TEAL.instance << 'box_put'
      end

      def bsqrt(big_endian_uint = nil)
        TEAL.instance << 'bsqrt'
      end

      def btoi(bytes = nil)
        TEAL.instance << 'btoi'
      end

      def byte(string)
        TEAL.instance << "byte \"#{string}\""
      end

      def bytec(index)
        TEAL.instance << "bytec #{index}"
      end

      def bytec_0 # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'bytec_0'
      end

      def bytec_1 # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'bytec_1'
      end

      def bytec_2 # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'bytec_2'
      end

      def bytec_3 # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'bytec_3'
      end

      def bytecblock(*bytes)
        TEAL.instance << "bytecblock #{bytes.join(' ')}"
      end

      def bz(target)
        TEAL.instance << "#{__method__} #{target}"
      end

      def bzero(length = nil)
        TEAL.instance << 'bzero'
      end

      def callsub(name, *_args)
        TEAL.instance << "callsub #{name}"
      end

      def concat(a = nil, b = nil)
        TEAL.instance << 'concat'
      end

      def cover(count)
        TEAL.instance << "cover #{count}"
      end

      def dig(index)
        TEAL.instance << "dig #{index}"
      end

      def divide(a = nil, b = nil)
        TEAL.instance << '/'
      end

      def divmodw(a = nil, b = nil)
        TEAL.instance << 'divmodw'
      end

      def divw(a = nil, b = nil)
        TEAL.instance << 'divw'
      end

      def dup(expr = nil)
        TEAL.instance << 'dup'
      end

      def dup2(expr_a = nil, expr_b = nil)
        TEAL.instance << 'dup2'
      end

      def ecdsa_pk_decompress(index, input = nil)
        TEAL.instance << "ecdsa_pk_decompress #{index}"
      end

      def ecdsa_pk_recover(index, input = nil)
        TEAL.instance << "ecdsa_pk_recover #{index}"
      end

      def ecdsa_verify(index, input = nil)
        TEAL.instance << "ecdsa_verify #{index}"
      end

      def ed25519verify(input = nil)
        TEAL.instance << 'ed25519verify'
      end

      def ed25519verify_bare(input = nil)
        TEAL.instance << 'ed25519verify_bare'
      end

      def equal(a = nil, b = nil)
        TEAL.instance << '=='
      end

      def err
        TEAL.instance << 'err'
      end

      def exp(a = nil, b = nil)
        TEAL.instance << 'exp'
      end

      def expw(a = nil, b = nil)
        TEAL.instance << 'expw'
      end

      def extract(start, length, byte_array = nil)
        TEAL.instance << "extract #{start} #{length}"
      end

      def extract3(byte_array = nil, start = nil, exclusive_end = nil)
        TEAL.instance << 'extract3'
      end

      def extract_uint16(byte_array = nil, start = nil)
        TEAL.instance << 'extract_uint16'
      end

      def extract_uint32(byte_array = nil, start = nil)
        TEAL.instance << 'extract_uint32'
      end

      def extract_uint64(byte_array = nil, start = nil)
        TEAL.instance << 'extract_uint64'
      end

      def gaid(transaction_index)
        TEAL.instance << "gaid #{transaction_index}"
      end

      def gaids(transaction = nil)
        TEAL.instance << 'gaids'
      end

      def getbit(input = nil, bit_index = nil)
        TEAL.instance << 'getbit'
      end

      def getbyte(input = nil, byte_index = nil)
        TEAL.instance << 'getbyte'
      end

      def gitxn(transaction_index, field)
        TEAL.instance << "gitxn #{transaction_index} #{field}"
      end

      def gitxna(transaction_index, field, index)
        TEAL.instance << "gitxna #{transaction_index} #{field} #{index}"
      end

      def gitxnas(transaction_index, field, index = nil)
        TEAL.instance << "gitxnas #{transaction_index} #{field}"
      end

      def gload(transaction_index, index)
        TEAL.instance << "gload #{transaction_index} #{index}"
      end

      def gloads(index, transaction_index = nil)
        TEAL.instance << "gloads #{index}"
      end

      def gloadss(transaction = nil, index = nil)
        TEAL.instance << 'gloadss'
      end

      def global(field)
        TEAL.instance << "global #{field}"
      end

      def greater(a = nil, b = nil)
        TEAL.instance << '>'
      end

      def greater_eq(a = nil, b = nil)
        TEAL.instance << '>='
      end

      def gtxn(index, field)
        TEAL.instance << "gtxn #{index} #{field}"
      end

      def gtxna(transaction_index, field, index)
        TEAL.instance << "gtxna #{transaction_index} #{field} #{index}"
      end

      def gtxns(field, transaction_index = nil)
        TEAL.instance << "gtxns #{field}"
      end

      def gtxnsa(field, index, transaction_index = nil)
        TEAL.instance << "gtxnsa #{field} #{index}"
      end

      def gtxnas(transaction_index, field, index = nil)
        TEAL.instance << "gtxnas #{transaction_index} #{field}"
      end

      def gtxnsas(field, transaction_index = nil, index = nil)
        TEAL.instance << "gtxnsas #{field}"
      end

      def int(integer)
        TEAL.instance << "int #{integer}"
      end

      def intc(index)
        TEAL.instance << "intc #{index}"
      end

      def intc_0 # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'intc_0'
      end

      def intc_1 # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'intc_1'
      end

      def intc_2 # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'intc_2'
      end

      def intc_3 # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'intc_3'
      end

      def intcblock(*ints)
        TEAL.instance << "intcblock #{ints.join(' ')}"
      end

      def itob(bytes = nil)
        TEAL.instance << 'itob'
      end

      def itxn_begin
        TEAL.instance << 'itxn_begin'
      end

      def itxn_field(field, value = nil)
        TEAL.instance << "itxn_field #{field}"
      end

      def itxn_next
        TEAL.instance << 'itxn_next'
      end

      def itxn_submit
        TEAL.instance << 'itxn_submit'
      end

      def itxna(field, index)
        TEAL.instance << "itxna #{field} #{index}"
      end

      def itxnas(field, index = nil)
        TEAL.instance << "itxnas #{field}"
      end

      def json_ref(type, object = nil, key = nil)
        TEAL.instance << "json_ref #{type}"
      end

      def keccak256(input = nil)
        TEAL.instance << 'keccak256'
      end

      def label(label_name)
        TEAL.instance << "#{label_name}:"
      end

      def len(input = nil)
        TEAL.instance << 'len'
      end

      def less(a = nil, b = nil)
        TEAL.instance << '<'
      end

      def less_eq(a = nil, b = nil)
        TEAL.instance << '<='
      end

      def load(index)
        TEAL.instance << "load #{index}"
      end

      def loads(index = nil)
        TEAL.instance << 'loads'
      end

      def log(byte_array = nil)
        TEAL.instance << 'log'
      end

      def method_signature(signature)
        TEAL.instance << %(method "#{signature}")
      end

      def min_balance(account = nil)
        TEAL.instance << 'min_balance'
      end

      def modulo(a = nil, b = nil)
        TEAL.instance << '%'
      end

      def multiply(a = nil, b = nil)
        TEAL.instance << '*'
      end

      def mulw(a = nil, b = nil)
        TEAL.instance << 'mulw'
      end

      def zero?(expr = nil)
        TEAL.instance << '!'
      end

      def not_equal(a = nil, b = nil)
        TEAL.instance << '!='
      end

      def padded_bitwise_and(a = nil, b = nil)
        TEAL.instance << 'b&'
      end

      def padded_bitwise_or(a = nil, b = nil)
        TEAL.instance << 'b|'
      end

      def padded_bitwise_xor(a = nil, b = nil)
        TEAL.instance << 'b^'
      end

      def pop(expr = nil)
        TEAL.instance << 'pop'
      end

      def pushbytes(string)
        TEAL.instance << "pushbytes \"#{string}\""
      end

      def pushint(integer)
        TEAL.instance << "pushint #{integer}"
      end

      def replace(a = nil, b = nil, c = nil)
        TEAL.instance << 'replace'
      end

      def replace2(start, a = nil, b = nil)
        TEAL.instance << "replace2 #{start}"
      end

      def retsub
        TEAL.instance << 'retsub'
      end

      def select(expr_a = nil, expr_b = nil, expr_c = nil)
        TEAL.instance << 'select'
      end

      def setbit(input = nil, bit_index = nil, value = nil)
        TEAL.instance << 'setbit'
      end

      def setbyte(byte_array = nil, byte_index = nil, value = nil)
        TEAL.instance << 'setbyte'
      end

      def sha256(input = nil)
        TEAL.instance << 'sha256'
      end

      def sha3_256(input = nil) # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'sha3_256'
      end

      def sha512_256(input = nil) # rubocop:disable Naming/VariableNumber
        TEAL.instance << 'sha512_256'
      end

      def shl(a = nil, b = nil)
        TEAL.instance << 'shl'
      end

      def shr(a = nil, b = nil)
        TEAL.instance << 'shr'
      end

      def sqrt(integer = nil)
        TEAL.instance << 'sqrt'
      end

      def store(index, value = nil)
        TEAL.instance << "store #{index}"
      end

      def stores(index = nil, value = nil)
        TEAL.instance << 'stores'
      end

      def substring(start, exclusive_end, byte_array = nil)
        TEAL.instance << "substring #{start} #{exclusive_end}"
      end

      def substring3(byte_array = nil, start = nil, exclusive_end = nil)
        TEAL.instance << 'substring3'
      end

      def subtract(a = nil, b = nil)
        TEAL.instance << '-'
      end

      def swap(expr_a = nil, expr_b = nil)
        TEAL.instance << 'swap'
      end

      def teal_return(expr = nil)
        TEAL.instance << 'return'
      end

      def txn(field)
        TEAL.instance << "txn #{field}"
      end

      def txna(field, index)
        TEAL.instance << "txna #{field} #{index}"
      end

      def txnas(field, index = nil)
        TEAL.instance << "txnas #{field}"
      end

      def uncover(count)
        TEAL.instance << "uncover #{count}"
      end

      def vrf_verify(standard, message = nil, proof = nil, public_key = nil)
        TEAL.instance << "vrf_verify #{standard}"
      end

      def boolean_and(a = nil, b = nil)
        TEAL.instance << '&&'
      end

      def boolean_or(a = nil, b = nil)
        TEAL.instance << '||'
      end
    end
  end
end

# rubocop:enable Lint/UnusedMethodArgument
