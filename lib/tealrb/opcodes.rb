# frozen_string_literal: true

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

    def acct_params_get(field, _account = nil)
      TEALrb::TEAL.current[Thread.current] << "acct_params_get #{field}"
    end

    def add(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '+'
    end

    def addr(address)
      TEALrb::TEAL.current[Thread.current] << "addr #{address}"
    end

    def addw(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'addw'
    end

    def app_global_del(_key = nil)
      TEALrb::TEAL.current[Thread.current] << 'app_global_del'
    end

    def app_global_get(_key = nil)
      TEALrb::TEAL.current[Thread.current] << 'app_global_get'
    end

    def app_global_get_ex(_app = nil, _key = nil)
      TEALrb::TEAL.current[Thread.current] << 'app_global_get_ex'
    end

    def app_global_put(_key = nil, _value = nil)
      TEALrb::TEAL.current[Thread.current] << 'app_global_put'
    end

    def app_local_del(_account = nil, _key = nil)
      TEALrb::TEAL.current[Thread.current] << 'app_local_del'
    end

    def app_local_get(_account = nil, _key = nil)
      TEALrb::TEAL.current[Thread.current] << 'app_local_get'
    end

    def app_local_get_ex(_account = nil, _application = nil, _key = nil)
      TEALrb::TEAL.current[Thread.current] << 'app_local_get_ex'
    end

    def app_local_put(_account = nil, _key = nil, _value = nil)
      TEALrb::TEAL.current[Thread.current] << 'app_local_put'
    end

    def app_opted_in(_account = nil, _app = nil)
      TEALrb::TEAL.current[Thread.current] << 'app_opted_in'
    end

    def app_params_get(field, _app_id = nil)
      TEALrb::TEAL.current[Thread.current] << "app_params_get #{field}"
    end

    def approve
      TEALrb::TEAL.current[Thread.current] << 'int 1'
      TEALrb::TEAL.current[Thread.current] << 'return'
    end

    def arg(index)
      TEALrb::TEAL.current[Thread.current] << "arg #{index}"
    end

    def arg_0 # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'arg_0'
    end

    def arg_1 # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'arg_1'
    end

    def arg_2 # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'arg_2'
    end

    def arg_3 # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'arg_3'
    end

    def args(_index = nil)
      TEALrb::TEAL.current[Thread.current] << 'args'
    end

    def assert(_expr = nil)
      TEALrb::TEAL.current[Thread.current] << 'assert'
    end

    def asset_holding_get(field, _account = nil, _asset = nil)
      TEALrb::TEAL.current[Thread.current] << "asset_holding_get #{field}"
    end

    def asset_params_get(field, _asset = nil)
      TEALrb::TEAL.current[Thread.current] << "asset_params_get #{field}"
    end

    def b(target)
      TEALrb::TEAL.current[Thread.current] << "#{__method__} #{target}"
    end

    def base32(input)
      TEALrb::TEAL.current[Thread.current] << "byte base32(#{input})"
    end

    def balance(_account = nil)
      TEALrb::TEAL.current[Thread.current] << 'balance'
    end

    def big_endian_add(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b+'
    end

    def big_endian_divide(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b/'
    end

    def big_endian_equal(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b=='
    end

    def big_endian_less(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b<'
    end

    def big_endian_less_eq(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b<='
    end

    def big_endian_modulo(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b%'
    end

    def big_endian_more(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b>'
    end

    def big_endian_more_eq(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b>='
    end

    def big_endian_multiply(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b*'
    end

    def big_endian_not_equal(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b!='
    end

    def big_endian_subtract(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b-'
    end

    def bitlen(_input = nil)
      TEALrb::TEAL.current[Thread.current] << 'bitlen'
    end

    def bitwise_and(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '&'
    end

    def bitwise_byte_invert(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b~'
    end

    def bitwise_invert(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '~'
    end

    def bitwise_or(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '|'
    end

    def bitwise_xor(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '^'
    end

    def bnz(target)
      TEALrb::TEAL.current[Thread.current] << "#{__method__} #{target}"
    end

    def bsqrt(_big_endian_uint = nil)
      TEALrb::TEAL.current[Thread.current] << 'bsqrt'
    end

    def btoi(_bytes = nil)
      TEALrb::TEAL.current[Thread.current] << 'btoi'
    end

    def byte(string, quote: true)
      teal_str = if quote
                   "byte \"#{string}\""
                 else
                   "byte #{string}"
                 end

      TEALrb::TEAL.current[Thread.current] << teal_str
    end

    def bytec(index)
      TEALrb::TEAL.current[Thread.current] << "bytec #{index}"
    end

    def bytec_0 # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'bytec_0'
    end

    def bytec_1 # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'bytec_1'
    end

    def bytec_2 # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'bytec_2'
    end

    def bytec_3 # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'bytec_3'
    end

    def bytecblock(*bytes)
      TEALrb::TEAL.current[Thread.current] << "bytecblock #{bytes.join(' ')}"
    end

    def bz(target)
      TEALrb::TEAL.current[Thread.current] << "#{__method__} #{target}"
    end

    def bzero(_length = nil)
      TEALrb::TEAL.current[Thread.current] << 'bzero'
    end

    def callsub(name, *_args)
      TEALrb::TEAL.current[Thread.current] << "callsub #{name}"
    end

    def concat(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'concat'
    end

    def cover(count)
      TEALrb::TEAL.current[Thread.current] << "cover #{count}"
    end

    def dig(index)
      TEALrb::TEAL.current[Thread.current] << "dig #{index}"
    end

    def divide(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '/'
    end

    def divmodw(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'divmodw'
    end

    def divw(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'divw'
    end

    def dup(_expr = nil)
      TEALrb::TEAL.current[Thread.current] << 'dup'
    end

    def dup2(_expr_a = nil, _expr_b = nil)
      TEALrb::TEAL.current[Thread.current] << 'dup2'
    end

    def ecdsa_pk_decompress(index, _input = nil)
      TEALrb::TEAL.current[Thread.current] << "ecdsa_pk_decompress #{index}"
    end

    def ecdsa_pk_recover(index, _input = nil)
      TEALrb::TEAL.current[Thread.current] << "ecdsa_pk_recover #{index}"
    end

    def ecdsa_verify(index, _input = nil)
      TEALrb::TEAL.current[Thread.current] << "ecdsa_verify #{index}"
    end

    def ed25519verify(_input = nil)
      TEALrb::TEAL.current[Thread.current] << 'ed25519verify'
    end

    def equal(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '=='
    end

    def err
      TEALrb::TEAL.current[Thread.current] << 'err'
    end

    def exp(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'exp'
    end

    def expw(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'expw'
    end

    def extract(start, length, _byte_array = nil)
      TEALrb::TEAL.current[Thread.current] << "extract #{start} #{length}"
    end

    def extract3(_byte_array = nil, _start = nil, _exclusive_end = nil)
      TEALrb::TEAL.current[Thread.current] << 'extract3'
    end

    def extract_uint16(_byte_array = nil, _start = nil)
      TEALrb::TEAL.current[Thread.current] << 'extract_uint16'
    end

    def extract_uint32(_byte_array = nil, _start = nil)
      TEALrb::TEAL.current[Thread.current] << 'extract_uint32'
    end

    def extract_uint64(_byte_array = nil, _start = nil)
      TEALrb::TEAL.current[Thread.current] << 'extract_uint64'
    end

    def gaid(transaction_index)
      TEALrb::TEAL.current[Thread.current] << "gaid #{transaction_index}"
    end

    def gaids(_transaction = nil)
      TEALrb::TEAL.current[Thread.current] << 'gaids'
    end

    def getbit(_input = nil, _bit_index = nil)
      TEALrb::TEAL.current[Thread.current] << 'getbit'
    end

    def getbyte(_input = nil, _byte_index = nil)
      TEALrb::TEAL.current[Thread.current] << 'getbyte'
    end

    def gitxn(transaction_index, field)
      TEALrb::TEAL.current[Thread.current] << "gitxn #{transaction_index} #{field}"
    end

    def gitxna(transaction_index, field, index)
      TEALrb::TEAL.current[Thread.current] << "gitxna #{transaction_index} #{field} #{index}"
    end

    def gitxnas(transaction_index, field, _index = nil)
      TEALrb::TEAL.current[Thread.current] << "gitxnas #{transaction_index} #{field}"
    end

    def gload(transaction_index, index)
      TEALrb::TEAL.current[Thread.current] << "gload #{transaction_index} #{index}"
    end

    def gloads(index, _transaction_index = nil)
      TEALrb::TEAL.current[Thread.current] << "gloads #{index}"
    end

    def gloadss(_transaction = nil, _index = nil)
      TEALrb::TEAL.current[Thread.current] << 'gloadss'
    end

    def global(field)
      TEALrb::TEAL.current[Thread.current] << "global #{field}"
    end

    def greater(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '>'
    end

    def greater_eq(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '>='
    end

    def gtxn(index, field)
      TEALrb::TEAL.current[Thread.current] << "gtxn #{index} #{field}"
    end

    def gtxna(transaction_index, field, index)
      TEALrb::TEAL.current[Thread.current] << "gtxna #{transaction_index} #{field} #{index}"
    end

    def gtxns(field, _transaction_index = nil)
      TEALrb::TEAL.current[Thread.current] << "gtxns #{field}"
    end

    def gtxnsa(field, index, _transaction_index = nil)
      TEALrb::TEAL.current[Thread.current] << "gtxnsa #{field} #{index}"
    end

    def gtxnas(transaction_index, field, _index = nil)
      TEALrb::TEAL.current[Thread.current] << "gtxnas #{transaction_index} #{field}"
    end

    def gtxnsas(field, _transaction_index = nil, _index = nil)
      TEALrb::TEAL.current[Thread.current] << "gtxnsas #{field}"
    end

    def int(integer)
      TEALrb::TEAL.current[Thread.current] << "int #{integer}"
    end

    def intc(index)
      TEALrb::TEAL.current[Thread.current] << "intc #{index}"
    end

    def intc_0 # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'intc_0'
    end

    def intc_1 # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'intc_1'
    end

    def intc_2 # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'intc_2'
    end

    def intc_3 # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'intc_3'
    end

    def intcblock(*ints)
      TEALrb::TEAL.current[Thread.current] << "intcblock #{ints.join(' ')}"
    end

    def itob(_bytes = nil)
      TEALrb::TEAL.current[Thread.current] << 'itob'
    end

    def itxn_begin
      TEALrb::TEAL.current[Thread.current] << 'itxn_begin'
    end

    def itxn_field(field, _value = nil)
      TEALrb::TEAL.current[Thread.current] << "itxn_field #{field}"
    end

    def itxn_next
      TEALrb::TEAL.current[Thread.current] << 'itxn_next'
    end

    def itxn_submit
      TEALrb::TEAL.current[Thread.current] << 'itxn_submit'
    end

    def itxna(field, index)
      TEALrb::TEAL.current[Thread.current] << "itxna #{field} #{index}"
    end

    def itxnas(field, _index = nil)
      TEALrb::TEAL.current[Thread.current] << "itxnas #{field}"
    end

    def keccak256(_input = nil)
      TEALrb::TEAL.current[Thread.current] << 'keccak256'
    end

    def label(label_name)
      TEALrb::TEAL.current[Thread.current] << "#{label_name}:"
    end

    def len(_input = nil)
      TEALrb::TEAL.current[Thread.current] << 'len'
    end

    def less(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '<'
    end

    def less_eq(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '<='
    end

    def load(index)
      TEALrb::TEAL.current[Thread.current] << "load #{index}"
    end

    def loads(_index = nil)
      TEALrb::TEAL.current[Thread.current] << 'loads'
    end

    def log(_byte_array = nil)
      TEALrb::TEAL.current[Thread.current] << 'log'
    end

    def method_signature(signature)
      TEALrb::TEAL.current[Thread.current] << %(method "#{signature}")
    end

    def min_balance(_account = nil)
      TEALrb::TEAL.current[Thread.current] << 'min_balance'
    end

    def modulo(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '%'
    end

    def multiply(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '*'
    end

    def mulw(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'mulw'
    end

    def zero?(_expr = nil)
      TEALrb::TEAL.current[Thread.current] << '!'
    end

    def not_equal(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '!='
    end

    def padded_bitwise_and(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b&'
    end

    def padded_bitwise_or(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b|'
    end

    def padded_bitwise_xor(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'b^'
    end

    def pop(_expr = nil)
      TEALrb::TEAL.current[Thread.current] << 'pop'
    end

    def pushbytes(string)
      TEALrb::TEAL.current[Thread.current] << "pushbytes \"#{string}\""
    end

    def pushint(integer)
      TEALrb::TEAL.current[Thread.current] << "pushint #{integer}"
    end

    def retsub
      TEALrb::TEAL.current[Thread.current] << 'retsub'
    end

    def select(_expr_a = nil, _expr_b = nil, _expr_c = nil)
      TEALrb::TEAL.current[Thread.current] << 'select'
    end

    def setbit(_input = nil, _bit_index = nil, _value = nil)
      TEALrb::TEAL.current[Thread.current] << 'setbit'
    end

    def setbyte(_byte_array = nil, _byte_index = nil, _value = nil)
      TEALrb::TEAL.current[Thread.current] << 'setbyte'
    end

    def sha256(_input = nil)
      TEALrb::TEAL.current[Thread.current] << 'sha256'
    end

    def sha512_256(_input = nil) # rubocop:disable Naming/VariableNumber
      TEALrb::TEAL.current[Thread.current] << 'sha512_256'
    end

    def shl(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'shl'
    end

    def shr(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << 'shr'
    end

    def sqrt(_integer = nil)
      TEALrb::TEAL.current[Thread.current] << 'sqrt'
    end

    def store(index, _value = nil)
      TEALrb::TEAL.current[Thread.current] << "store #{index}"
    end

    def stores(_index = nil, _value = nil)
      TEALrb::TEAL.current[Thread.current] << 'stores'
    end

    def substring(start, exclusive_end, _byte_array = nil)
      TEALrb::TEAL.current[Thread.current] << "substring #{start} #{exclusive_end}"
    end

    def substring3(_byte_array = nil, _start = nil, _exclusive_end = nil)
      TEALrb::TEAL.current[Thread.current] << 'substring3'
    end

    def subtract(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '-'
    end

    def swap(_expr_a = nil, _expr_b = nil)
      TEALrb::TEAL.current[Thread.current] << 'swap'
    end

    def teal_return(_expr = nil)
      TEALrb::TEAL.current[Thread.current] << 'return'
    end

    def txn(field)
      TEALrb::TEAL.current[Thread.current] << "txn #{field}"
    end

    def txna(field, index)
      TEALrb::TEAL.current[Thread.current] << "txna #{field} #{index}"
    end

    def txnas(field, _index = nil)
      TEALrb::TEAL.current[Thread.current] << "txnas #{field}"
    end

    def uncover(count)
      TEALrb::TEAL.current[Thread.current] << "uncover #{count}"
    end

    def boolean_and(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '&&'
    end

    def boolean_or(_a = nil, _b = nil)
      TEALrb::TEAL.current[Thread.current] << '||'
    end
  end
end
