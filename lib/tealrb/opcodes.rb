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
        @teal << "acct_params_get #{field}"
        self
      end

      def add(a = nil, b = nil)
        @teal << '+'
        self
      end

      def addr(address)
        @teal << "addr #{address}"
        self
      end

      def addw(a = nil, b = nil)
        @teal << 'addw'
        self
      end

      def app_global_del(key = nil)
        @teal << 'app_global_del'
        self
      end

      def app_global_get(key = nil)
        @teal << 'app_global_get'
        self
      end

      def app_global_get_ex(app = nil, key = nil)
        @teal << 'app_global_get_ex'
        self
      end

      def app_global_put(key = nil, value = nil)
        @teal << 'app_global_put'
        self
      end

      def app_local_del(account = nil, key = nil)
        @teal << 'app_local_del'
        self
      end

      def app_local_get(account = nil, key = nil)
        @teal << 'app_local_get'
        self
      end

      def app_local_get_ex(account = nil, application = nil, key = nil)
        @teal << 'app_local_get_ex'
        self
      end

      def app_local_put(account = nil, key = nil, value = nil)
        @teal << 'app_local_put'
        self
      end

      def app_opted_in(account = nil, app = nil)
        @teal << 'app_opted_in'
        self
      end

      def app_params_get(field, app_id = nil)
        @teal << "app_params_get #{field}"
        self
      end

      def approve
        @teal << 'int 1'
        @teal << 'return'
        self
      end

      def arg(index)
        @teal << "arg #{index}"
        self
      end

      def arg_0 # rubocop:disable Naming/VariableNumber
        @teal << 'arg_0'
        self
      end

      def arg_1 # rubocop:disable Naming/VariableNumber
        @teal << 'arg_1'
        self
      end

      def arg_2 # rubocop:disable Naming/VariableNumber
        @teal << 'arg_2'
        self
      end

      def arg_3 # rubocop:disable Naming/VariableNumber
        @teal << 'arg_3'
        self
      end

      def args(index = nil)
        @teal << 'args'
        self
      end

      def assert(expr = nil)
        @teal << 'assert'
        self
      end

      def asset_holding_get(field, account = nil, asset = nil)
        @teal << "asset_holding_get #{field}"
        self
      end

      def asset_params_get(field, asset = nil)
        @teal << "asset_params_get #{field}"
        self
      end

      def b(target)
        @teal << "#{__method__} #{target}"
        self
      end

      def base32(input)
        @teal << "byte base32(#{input})"
        self
      end

      def base64_decode(encoding, input = nil)
        @teal << "base64_decode #{encoding}"
        self
      end

      def balance(account = nil)
        @teal << 'balance'
        self
      end

      def big_endian_add(a = nil, b = nil)
        @teal << 'b+'
        self
      end

      def big_endian_divide(a = nil, b = nil)
        @teal << 'b/'
        self
      end

      def big_endian_equal(a = nil, b = nil)
        @teal << 'b=='
        self
      end

      def big_endian_less(a = nil, b = nil)
        @teal << 'b<'
        self
      end

      def big_endian_less_eq(a = nil, b = nil)
        @teal << 'b<='
        self
      end

      def big_endian_modulo(a = nil, b = nil)
        @teal << 'b%'
        self
      end

      def big_endian_more(a = nil, b = nil)
        @teal << 'b>'
        self
      end

      def big_endian_more_eq(a = nil, b = nil)
        @teal << 'b>='
        self
      end

      def big_endian_multiply(a = nil, b = nil)
        @teal << 'b*'
        self
      end

      def big_endian_not_equal(a = nil, b = nil)
        @teal << 'b!='
        self
      end

      def big_endian_subtract(a = nil, b = nil)
        @teal << 'b-'
        self
      end

      def bitlen(input = nil)
        @teal << 'bitlen'
        self
      end

      def bitwise_and(a = nil, b = nil)
        @teal << '&'
        self
      end

      def bitwise_byte_invert(a = nil, b = nil)
        @teal << 'b~'
        self
      end

      def bitwise_invert(a = nil, b = nil)
        @teal << '~'
        self
      end

      def bitwise_or(a = nil, b = nil)
        @teal << '|'
        self
      end

      def bitwise_xor(a = nil, b = nil)
        @teal << '^'
        self
      end

      def bnz(target)
        @teal << "#{__method__} #{target}"
        self
      end

      def box_create(name = nil, length = nil)
        @teal << 'box_create'
        self
      end

      def box_extract(name = nil, offset = nil, length = nil)
        @teal << 'box_extract'
        self
      end

      def box_replace(name = nil, offset = nil, value = nil)
        @teal << 'box_replace'
        self
      end

      def box_del(name = nil)
        @teal << 'box_del'
        self
      end

      def box_len(name = nil)
        @teal << 'box_len'
        self
      end

      def box_get(name = nil)
        @teal << 'box_get'
        self
      end

      def box_put(name = nil, value = nil)
        @teal << 'box_put'
        self
      end

      def bsqrt(big_endian_uint = nil)
        @teal << 'bsqrt'
        self
      end

      def btoi(bytes = nil)
        @teal << 'btoi'
        self
      end

      def byte(string)
        @teal << "byte \"#{string}\""
        self
      end

      def bytec(index)
        @teal << "bytec #{index}"
        self
      end

      def bytec_0 # rubocop:disable Naming/VariableNumber
        @teal << 'bytec_0'
        self
      end

      def bytec_1 # rubocop:disable Naming/VariableNumber
        @teal << 'bytec_1'
        self
      end

      def bytec_2 # rubocop:disable Naming/VariableNumber
        @teal << 'bytec_2'
        self
      end

      def bytec_3 # rubocop:disable Naming/VariableNumber
        @teal << 'bytec_3'
        self
      end

      def bytecblock(*bytes)
        @teal << "bytecblock #{bytes.join(' ')}"
        self
      end

      def bz(target)
        @teal << "#{__method__} #{target}"
        self
      end

      def bzero(length = nil)
        @teal << 'bzero'
        self
      end

      def callsub(name, *_args)
        @teal << "callsub #{name}"
        self
      end

      def concat(a = nil, b = nil)
        @teal << 'concat'
        self
      end

      def cover(count)
        @teal << "cover #{count}"
        self
      end

      def dig(index)
        @teal << "dig #{index}"
        self
      end

      def divide(a = nil, b = nil)
        @teal << '/'
        self
      end

      def divmodw(a = nil, b = nil)
        @teal << 'divmodw'
        self
      end

      def divw(a = nil, b = nil)
        @teal << 'divw'
        self
      end

      def dup(expr = nil)
        @teal << 'dup'
        self
      end

      def dup2(expr_a = nil, expr_b = nil)
        @teal << 'dup2'
        self
      end

      def ecdsa_pk_decompress(index, input = nil)
        @teal << "ecdsa_pk_decompress #{index}"
        self
      end

      def ecdsa_pk_recover(index, input = nil)
        @teal << "ecdsa_pk_recover #{index}"
        self
      end

      def ecdsa_verify(index, input = nil)
        @teal << "ecdsa_verify #{index}"
        self
      end

      def ed25519verify(input = nil)
        @teal << 'ed25519verify'
        self
      end

      def ed25519verify_bare(input = nil)
        @teal << 'ed25519verify_bare'
        self
      end

      def equal(a = nil, b = nil)
        @teal << '=='
        self
      end

      def err
        @teal << 'err'
        self
      end

      def exp(a = nil, b = nil)
        @teal << 'exp'
        self
      end

      def expw(a = nil, b = nil)
        @teal << 'expw'
        self
      end

      def extract(start, length, byte_array = nil)
        @teal << "extract #{start} #{length}"
        self
      end

      def extract3(byte_array = nil, start = nil, exclusive_end = nil)
        @teal << 'extract3'
        self
      end

      def extract_uint16(byte_array = nil, start = nil)
        @teal << 'extract_uint16'
        self
      end

      def extract_uint32(byte_array = nil, start = nil)
        @teal << 'extract_uint32'
        self
      end

      def extract_uint64(byte_array = nil, start = nil)
        @teal << 'extract_uint64'
        self
      end

      def gaid(transaction_index)
        @teal << "gaid #{transaction_index}"
        self
      end

      def gaids(transaction = nil)
        @teal << 'gaids'
        self
      end

      def getbit(input = nil, bit_index = nil)
        @teal << 'getbit'
        self
      end

      def getbyte(input = nil, byte_index = nil)
        @teal << 'getbyte'
        self
      end

      def gitxn(transaction_index, field)
        @teal << "gitxn #{transaction_index} #{field}"
        self
      end

      def gitxna(transaction_index, field, index)
        @teal << "gitxna #{transaction_index} #{field} #{index}"
        self
      end

      def gitxnas(transaction_index, field, index = nil)
        @teal << "gitxnas #{transaction_index} #{field}"
        self
      end

      def gload(transaction_index, index)
        @teal << "gload #{transaction_index} #{index}"
        self
      end

      def gloads(index, transaction_index = nil)
        @teal << "gloads #{index}"
        self
      end

      def gloadss(transaction = nil, index = nil)
        @teal << 'gloadss'
        self
      end

      def global(field)
        @teal << "global #{field}"
        self
      end

      def greater(a = nil, b = nil)
        @teal << '>'
        self
      end

      def greater_eq(a = nil, b = nil)
        @teal << '>='
        self
      end

      def gtxn(index, field)
        @teal << "gtxn #{index} #{field}"
        self
      end

      def gtxna(transaction_index, field, index)
        @teal << "gtxna #{transaction_index} #{field} #{index}"
        self
      end

      def gtxns(field, transaction_index = nil)
        @teal << "gtxns #{field}"
        self
      end

      def gtxnsa(field, index, transaction_index = nil)
        @teal << "gtxnsa #{field} #{index}"
        self
      end

      def gtxnas(transaction_index, field, index = nil)
        @teal << "gtxnas #{transaction_index} #{field}"
        self
      end

      def gtxnsas(field, transaction_index = nil, index = nil)
        @teal << "gtxnsas #{field}"
        self
      end

      def int(integer)
        @teal << "int #{integer}"
        self
      end

      def intc(index)
        @teal << "intc #{index}"
        self
      end

      def intc_0 # rubocop:disable Naming/VariableNumber
        @teal << 'intc_0'
        self
      end

      def intc_1 # rubocop:disable Naming/VariableNumber
        @teal << 'intc_1'
        self
      end

      def intc_2 # rubocop:disable Naming/VariableNumber
        @teal << 'intc_2'
        self
      end

      def intc_3 # rubocop:disable Naming/VariableNumber
        @teal << 'intc_3'
        self
      end

      def intcblock(*ints)
        @teal << "intcblock #{ints.join(' ')}"
        self
      end

      def itob(bytes = nil)
        @teal << 'itob'
        self
      end

      def itxn_begin
        @teal << 'itxn_begin'
        self
      end

      def itxn_field(field, value = nil)
        @teal << "itxn_field #{field}"
        self
      end

      def itxn_next
        @teal << 'itxn_next'
        self
      end

      def itxn_submit
        @teal << 'itxn_submit'
        self
      end

      def itxna(field, index)
        @teal << "itxna #{field} #{index}"
        self
      end

      def itxnas(field, index = nil)
        @teal << "itxnas #{field}"
        self
      end

      def json_ref(type, object = nil, key = nil)
        @teal << "json_ref #{type}"
        self
      end

      def keccak256(input = nil)
        @teal << 'keccak256'
        self
      end

      def label(label_name)
        @teal << "#{label_name}:"
        self
      end

      def len(input = nil)
        @teal << 'len'
        self
      end

      def less(a = nil, b = nil)
        @teal << '<'
        self
      end

      def less_eq(a = nil, b = nil)
        @teal << '<='
        self
      end

      def load(index)
        @teal << "load #{index}"
        self
      end

      def loads(index = nil)
        @teal << 'loads'
        self
      end

      def log(byte_array = nil)
        @teal << 'log'
        self
      end

      def method_signature(signature)
        @teal << %(method "#{signature}")
        self
      end

      def min_balance(account = nil)
        @teal << 'min_balance'
        self
      end

      def modulo(a = nil, b = nil)
        @teal << '%'
        self
      end

      def multiply(a = nil, b = nil)
        @teal << '*'
        self
      end

      def mulw(a = nil, b = nil)
        @teal << 'mulw'
        self
      end

      def zero?(expr = nil)
        @teal << '!'
        self
      end

      def not_equal(a = nil, b = nil)
        @teal << '!='
        self
      end

      def padded_bitwise_and(a = nil, b = nil)
        @teal << 'b&'
        self
      end

      def padded_bitwise_or(a = nil, b = nil)
        @teal << 'b|'
        self
      end

      def padded_bitwise_xor(a = nil, b = nil)
        @teal << 'b^'
        self
      end

      def pop(expr = nil)
        @teal << 'pop'
        self
      end

      def pushbytes(string)
        @teal << "pushbytes \"#{string}\""
        self
      end

      def pushint(integer)
        @teal << "pushint #{integer}"
        self
      end

      def replace(a = nil, b = nil, c = nil)
        @teal << 'replace'
        self
      end

      def replace2(start, a = nil, b = nil)
        @teal << "replace2 #{start}"
        self
      end

      def retsub
        @teal << 'retsub'
        self
      end

      def select(expr_a = nil, expr_b = nil, expr_c = nil)
        @teal << 'select'
        self
      end

      def setbit(input = nil, bit_index = nil, value = nil)
        @teal << 'setbit'
        self
      end

      def setbyte(byte_array = nil, byte_index = nil, value = nil)
        @teal << 'setbyte'
        self
      end

      def sha256(input = nil)
        @teal << 'sha256'
        self
      end

      def sha3_256(input = nil)
        # rubocop:disable Naming/VariableNumber
        @teal << 'sha3_256'
        self
      end

      def sha512_256(input = nil)
        @teal << 'sha512_256'
        self
      end

      def shl(a = nil, b = nil)
        @teal << 'shl'
        self
      end

      def shr(a = nil, b = nil)
        @teal << 'shr'
        self
      end

      def sqrt(integer = nil)
        @teal << 'sqrt'
        self
      end

      def store(index, value = nil)
        @teal << "store #{index}"
        self
      end

      def stores(index = nil, value = nil)
        @teal << 'stores'
        self
      end

      def substring(start, exclusive_end, byte_array = nil)
        @teal << "substring #{start} #{exclusive_end}"
        self
      end

      def substring3(byte_array = nil, start = nil, exclusive_end = nil)
        @teal << 'substring3'
        self
      end

      def subtract(a = nil, b = nil)
        @teal << '-'
        self
      end

      def swap(expr_a = nil, expr_b = nil)
        @teal << 'swap'
        self
      end

      def teal_return(expr = nil)
        @teal << 'return'
        self
      end

      def txn(field)
        @teal << "txn #{field}"
        self
      end

      def txna(field, index)
        @teal << "txna #{field} #{index}"
        self
      end

      def txnas(field, index = nil)
        @teal << "txnas #{field}"
        self
      end

      def uncover(count)
        @teal << "uncover #{count}"
        self
      end

      def vrf_verify(standard, message = nil, proof = nil, public_key = nil)
        @teal << "vrf_verify #{standard}"
        self
      end

      def boolean_and(a = nil, b = nil)
        @teal << '&&'
        self
      end

      def boolean_or(a = nil, b = nil)
        @teal << '||'
        self
      end
    end
  end
end

# rubocop:enable Lint/UnusedMethodArgument
