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
      @teal << "acct_params_get #{field}"
    end

    def add(_a = nil, _b = nil)
      @teal << '+'
    end

    def addw(_a = nil, _b = nil)
      @teal << 'addw'
    end

    def app_global_del(_key = nil)
      @teal << 'app_global_del'
    end

    def app_global_get(_key = nil)
      @teal << 'app_global_get'
    end

    def app_global_get_ex(_app = nil, _key = nil)
      @teal << 'app_global_get_ex'
    end

    def app_global_put(_key = nil, _value = nil)
      @teal << 'app_global_put'
    end

    def app_local_del(_account = nil, _key = nil)
      @teal << 'app_local_del'
    end

    def app_local_get(_account = nil, _key = nil)
      @teal << 'app_local_get'
    end

    def app_local_get_ex(_account = nil, _application = nil, _key = nil)
      @teal << 'app_local_get_ex'
    end

    def app_local_put(_account = nil, _key = nil, _value = nil)
      @teal << 'app_local_put'
    end

    def app_opted_in(_account = nil, _app = nil)
      @teal << 'app_opted_in'
    end

    def app_params_get(field, _app_id = nil)
      @teal << "app_params_get #{field}"
    end

    def approve
      @teal << 'return'
    end

    def arg(index)
      @teal << "arg #{index}"
    end

    def arg_0
      @teal << 'arg_0'
    end

    def arg_1
      @teal << 'arg_1'
    end

    def arg_2
      @teal << 'arg_2'
    end

    def arg_3
      @teal << 'arg_3'
    end

    def args(_index = nil)
      @teal << 'args'
    end

    def assert(_expr = nil)
      @teal << 'assert'
    end

    def asset_holding_get(field, _account = nil, _asset = nil)
      @teal << "asset_holding_get #{field}"
    end

    def asset_params_get(field, _asset = nil)
      @teal << "asset_params_get #{field}"
    end

    def b(target)
      @teal << "#{__method__} #{target}"
    end

    def balance(_account = nil)
      @teal << 'balance'
    end

    def big_endian_add(_a = nil, _b = nil)
      @teal << 'b+'
    end

    def big_endian_divide(_a = nil, _b = nil)
      @teal << 'b/'
    end

    def big_endian_equal(_a = nil, _b = nil)
      @teal << 'b=='
    end

    def big_endian_less(_a = nil, _b = nil)
      @teal << 'b<'
    end

    def big_endian_less_eq(_a = nil, _b = nil)
      @teal << 'b<='
    end

    def big_endian_modulo(_a = nil, _b = nil)
      @teal << 'b%'
    end

    def big_endian_more(_a = nil, _b = nil)
      @teal << 'b>'
    end

    def big_endian_more_eq(_a = nil, _b = nil)
      @teal << 'b>='
    end

    def big_endian_multiply(_a = nil, _b = nil)
      @teal << 'b*'
    end

    def big_endian_not_equal(_a = nil, _b = nil)
      @teal << 'b!='
    end

    def big_endian_subtract(_a = nil, _b = nil)
      @teal << 'b-'
    end

    def bitlen(_input = nil)
      @teal << 'bitlen'
    end

    def bitwise_and(_a = nil, _b = nil)
      @teal << '&'
    end

    def bitwise_byte_invert(_a = nil, _b = nil)
      @teal << 'b~'
    end

    def bitwise_invert(_a = nil, _b = nil)
      @teal << '~'
    end

    def bitwise_or(_a = nil, _b = nil)
      @teal << '|'
    end

    def bitwise_xor(_a = nil, _b = nil)
      @teal << '^'
    end

    def bnz(target)
      @teal << "#{__method__} #{target}"
    end

    def bsqrt(_big_endian_uint = nil)
      @teal << 'bsqrt'
    end

    def btoi(_bytes = nil)
      @teal << 'btoi'
    end

    def byte(string)
      @teal << "byte \"#{string}\""
    end

    def bytec(index)
      @teal << "bytec #{index}"
    end

    def bytec_0
      @teal << 'bytec_0'
    end

    def bytec_1
      @teal << 'bytec_1'
    end

    def bytec_2
      @teal << 'bytec_2'
    end

    def bytec_3
      @teal << 'bytec_3'
    end

    def bytecblock(*bytes)
      @teal << "bytecblock #{bytes.join(' ')}"
    end

    def bz(target)
      @teal << "#{__method__} #{target}"
    end

    def bzero(_length = nil)
      @teal << 'bzero'
    end

    def callsub(name, *_args)
      @teal << "callsub #{name}"
    end

    def concat(_a = nil, _b = nil)
      @teal << 'concat'
    end

    def cover(count)
      @teal << "cover #{count}"
    end

    def dig(index)
      @teal << "dig #{index}"
    end

    def divide(_a = nil, _b = nil)
      @teal << '/'
    end

    def divmodw(_a = nil, _b = nil)
      @teal << 'divmodw'
    end

    def divw(_a = nil, _b = nil)
      @teal << 'divw'
    end

    def dup(_expr = nil)
      @teal << 'dup'
    end

    def dup2(_expr_a = nil, _expr_b = nil)
      @teal << 'dup2'
    end

    def ecdsa_pk_decompress(index, _input = nil)
      @teal << "ecdsa_pk_decompress #{index}"
    end

    def ecdsa_pk_recover(index, _input = nil)
      @teal << "ecdsa_pk_recover #{index}"
    end

    def ecdsa_verify(index, _input = nil)
      @teal << "ecdsa_verify #{index}"
    end

    def ed25519verify(_input = nil)
      @teal << 'ed25519verify'
    end

    def equal(_a = nil, _b = nil)
      @teal << '=='
    end

    def err
      @teal << 'err'
    end

    def exp(_a = nil, _b = nil)
      @teal << 'exp'
    end

    def expw(_a = nil, _b = nil)
      @teal << 'expw'
    end

    def extract(start, length, _byte_array = nil)
      @teal << "extract #{start} #{length}"
    end

    def extract3(_byte_array = nil, _start = nil, _exclusive_end = nil)
      @teal << 'extract3'
    end

    def extract_uint16(_byte_array = nil, _start = nil)
      @teal << 'extract_uint16'
    end

    def extract_uint32(_byte_array = nil, _start = nil)
      @teal << 'extract_uint32'
    end

    def extract_uint64(_byte_array = nil, _start = nil)
      @teal << 'extract_uint64'
    end

    def gaid(transaction_index)
      @teal << "gaid #{transaction_index}"
    end

    def gaids(_transaction = nil)
      @teal << 'gaids'
    end

    def getbit(_input = nil, _bit_index = nil)
      @teal << 'getbit'
    end

    def getbyte(_input = nil, _byte_index = nil)
      @teal << 'getbyte'
    end

    def gitxn(transaction_index, field)
      @teal << "gitxn #{transaction_index} #{field}"
    end

    def gitxna(transaction_index, field, index)
      @teal << "gitxna #{transaction_index} #{field} #{index}"
    end

    def gitxnas(transaction_index, field, _index = nil)
      @teal << "gitxnas #{transaction_index} #{field}"
    end

    def gload(transaction_index, index)
      @teal << "gload #{transaction_index} #{index}"
    end

    def gloads(index, _transaction_index = nil)
      @teal << "gloads #{index}"
    end

    def gloadss(_transaction = nil, _index = nil)
      @teal << 'gloadss'
    end

    def global(field)
      @teal << "global #{field}"
    end

    def greater(_a = nil, _b = nil)
      @teal << '>'
    end

    def greater_eq(_a = nil, _b = nil)
      @teal << '>='
    end

    def gtxn(index, field)
      @teal << "gtxn #{index} #{field}"
    end

    def gtxna(transaction_index, field, index)
      @teal << "gtxna #{transaction_index} #{field} #{index}"
    end

    def gtxns(field, _transaction_index = nil)
      @teal << "gtxns #{field}"
    end

    def gtxnsa(field, index, _transaction_index = nil)
      @teal << "gtxnsa #{field} #{index}"
    end

    def gtxnas(transaction_index, field, _index = nil)
      @teal << "gtxnas #{transaction_index} #{field}"
    end

    def gtxnsas(field, _transaction_index = nil, _index = nil)
      @teal << "gtxnsas #{field}"
    end

    def int(integer)
      @teal << "int #{integer}"
    end

    def intc(index)
      @teal << "intc #{index}"
    end

    def intc_0
      @teal << 'intc_0'
    end

    def intc_1
      @teal << 'intc_1'
    end

    def intc_2
      @teal << 'intc_2'
    end

    def intc_3
      @teal << 'intc_3'
    end

    def intcblock(*ints)
      @teal << "intcblock #{ints.join(' ')}"
    end

    def itob(_bytes = nil)
      @teal << 'itob'
    end

    def itxn_begin
      @teal << 'itxn_begin'
    end

    def itxn_field(field, _value = nil)
      @teal << "itxn_field #{field}"
    end

    def itxn_next
      @teal << 'itxn_next'
    end

    def itxn_submit
      @teal << 'itxn_submit'
    end

    def itxna(field, index)
      @teal << "itxna #{field} #{index}"
    end

    def itxnas(field, _index = nil)
      @teal << "itxnas #{field}"
    end

    def keccak256(_input = nil)
      @teal << 'keccak256'
    end

    def label(label_name)
      @teal << "#{label_name}:"
    end

    def len(_input = nil)
      @teal << 'len'
    end

    def less(_a = nil, _b = nil)
      @teal << '<'
    end

    def less_eq(_a = nil, _b = nil)
      @teal << '<='
    end

    def load(index)
      @teal << "load #{index}"
    end

    def loads(_index = nil)
      @teal << 'loads'
    end

    def log(_byte_array = nil)
      @teal << 'log'
    end

    def min_balance(_account = nil)
      @teal << 'min_balance'
    end

    def modulo(_a = nil, _b = nil)
      @teal << '%'
    end

    def multiply(_a = nil, _b = nil)
      @teal << '*'
    end

    def mulw(_a = nil, _b = nil)
      @teal << 'mulw'
    end

    def zero?(_expr = nil)
      @teal << '!'
    end

    def not_equal(_a = nil, _b = nil)
      @teal << '!='
    end

    def padded_bitwise_and(_a = nil, _b = nil)
      @teal << 'b&'
    end

    def padded_bitwise_or(_a = nil, _b = nil)
      @teal << 'b|'
    end

    def padded_bitwise_xor(_a = nil, _b = nil)
      @teal << 'b^'
    end

    def pop(_expr = nil)
      @teal << 'pop'
    end

    def pushbytes(string)
      @teal << "pushbytes \"#{string}\""
    end

    def pushint(integer)
      @teal << "pushint #{integer}"
    end

    def retsub
      @teal << 'retsub'
    end

    def select(_expr_a = nil, _expr_b = nil, _expr_c = nil)
      @teal << 'select'
    end

    def setbit(_input = nil, _bit_index = nil, _value = nil)
      @teal << 'setbit'
    end

    def setbyte(_byte_array = nil, _byte_index = nil, _value = nil)
      @teal << 'setbyte'
    end

    def sha256(_input = nil)
      @teal << 'sha256'
    end

    def sha512_256(_input = nil)
      @teal << 'sha512_256'
    end

    def shl(_a = nil, _b = nil)
      @teal << 'shl'
    end

    def shr(_a = nil, _b = nil)
      @teal << 'shr'
    end

    def sqrt(_integer = nil)
      @teal << 'sqrt'
    end

    def store(index, _value = nil)
      @teal << "store #{index}"
    end

    def stores(_index = nil, _value = nil)
      @teal << 'stores'
    end

    def substring(start, exclusive_end, _byte_array = nil)
      @teal << "substring #{start} #{exclusive_end}"
    end

    def substring3(_byte_array = nil, _start = nil, _exclusive_end = nil)
      @teal << 'substring3'
    end

    def subtract(_a = nil, _b = nil)
      @teal << '-'
    end

    def swap(_expr_a = nil, _expr_b = nil)
      @teal << 'swap'
    end

    def teal_return(_expr = nil)
      @teal << 'return'
    end

    def txn(field)
      @teal << "txn #{field}"
    end

    def txna(field, index)
      @teal << "txna #{field} #{index}"
    end

    def txnas(field, _index = nil)
      @teal << "txnas #{field}"
    end

    def uncover(count)
      @teal << "uncover #{count}"
    end

    def boolean_and(_a = nil, _b = nil)
      @teal << '&&'
    end

    def boolean_or(_a = nil, _b = nil)
      @teal << '||'
    end
  end
end
