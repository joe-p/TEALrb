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
      TEAL.instance << "acct_params_get #{field}"
    end

    def add(_a = nil, _b = nil)
      TEAL.instance << '+'
    end

    def addr(address)
      TEAL.instance << "addr #{address}"
    end

    def addw(_a = nil, _b = nil)
      TEAL.instance << 'addw'
    end

    def app_global_del(_key = nil)
      TEAL.instance << 'app_global_del'
    end

    def app_global_get(_key = nil)
      TEAL.instance << 'app_global_get'
    end

    def app_global_get_ex(_app = nil, _key = nil)
      TEAL.instance << 'app_global_get_ex'
    end

    def app_global_put(_key = nil, _value = nil)
      TEAL.instance << 'app_global_put'
    end

    def app_local_del(_account = nil, _key = nil)
      TEAL.instance << 'app_local_del'
    end

    def app_local_get(_account = nil, _key = nil)
      TEAL.instance << 'app_local_get'
    end

    def app_local_get_ex(_account = nil, _application = nil, _key = nil)
      TEAL.instance << 'app_local_get_ex'
    end

    def app_local_put(_account = nil, _key = nil, _value = nil)
      TEAL.instance << 'app_local_put'
    end

    def app_opted_in(_account = nil, _app = nil)
      TEAL.instance << 'app_opted_in'
    end

    def app_params_get(field, _app_id = nil)
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

    def args(_index = nil)
      TEAL.instance << 'args'
    end

    def assert(_expr = nil)
      TEAL.instance << 'assert'
    end

    def asset_holding_get(field, _account = nil, _asset = nil)
      TEAL.instance << "asset_holding_get #{field}"
    end

    def asset_params_get(field, _asset = nil)
      TEAL.instance << "asset_params_get #{field}"
    end

    def b(target)
      TEAL.instance << "#{__method__} #{target}"
    end

    def base32(input)
      TEAL.instance << "byte base32(#{input})"
    end

    def balance(_account = nil)
      TEAL.instance << 'balance'
    end

    def big_endian_add(_a = nil, _b = nil)
      TEAL.instance << 'b+'
    end

    def big_endian_divide(_a = nil, _b = nil)
      TEAL.instance << 'b/'
    end

    def big_endian_equal(_a = nil, _b = nil)
      TEAL.instance << 'b=='
    end

    def big_endian_less(_a = nil, _b = nil)
      TEAL.instance << 'b<'
    end

    def big_endian_less_eq(_a = nil, _b = nil)
      TEAL.instance << 'b<='
    end

    def big_endian_modulo(_a = nil, _b = nil)
      TEAL.instance << 'b%'
    end

    def big_endian_more(_a = nil, _b = nil)
      TEAL.instance << 'b>'
    end

    def big_endian_more_eq(_a = nil, _b = nil)
      TEAL.instance << 'b>='
    end

    def big_endian_multiply(_a = nil, _b = nil)
      TEAL.instance << 'b*'
    end

    def big_endian_not_equal(_a = nil, _b = nil)
      TEAL.instance << 'b!='
    end

    def big_endian_subtract(_a = nil, _b = nil)
      TEAL.instance << 'b-'
    end

    def bitlen(_input = nil)
      TEAL.instance << 'bitlen'
    end

    def bitwise_and(_a = nil, _b = nil)
      TEAL.instance << '&'
    end

    def bitwise_byte_invert(_a = nil, _b = nil)
      TEAL.instance << 'b~'
    end

    def bitwise_invert(_a = nil, _b = nil)
      TEAL.instance << '~'
    end

    def bitwise_or(_a = nil, _b = nil)
      TEAL.instance << '|'
    end

    def bitwise_xor(_a = nil, _b = nil)
      TEAL.instance << '^'
    end

    def bnz(target)
      TEAL.instance << "#{__method__} #{target}"
    end

    def bsqrt(_big_endian_uint = nil)
      TEAL.instance << 'bsqrt'
    end

    def btoi(_bytes = nil)
      TEAL.instance << 'btoi'
    end

    def byte(string, quote: true)
      teal_str = if quote
                   "byte \"#{string}\""
                 else
                   "byte #{string}"
                 end

      TEAL.instance << teal_str
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

    def bzero(_length = nil)
      TEAL.instance << 'bzero'
    end

    def callsub(name, *_args)
      TEAL.instance << "callsub #{name}"
    end

    def concat(_a = nil, _b = nil)
      TEAL.instance << 'concat'
    end

    def cover(count)
      TEAL.instance << "cover #{count}"
    end

    def dig(index)
      TEAL.instance << "dig #{index}"
    end

    def divide(_a = nil, _b = nil)
      TEAL.instance << '/'
    end

    def divmodw(_a = nil, _b = nil)
      TEAL.instance << 'divmodw'
    end

    def divw(_a = nil, _b = nil)
      TEAL.instance << 'divw'
    end

    def dup(_expr = nil)
      TEAL.instance << 'dup'
    end

    def dup2(_expr_a = nil, _expr_b = nil)
      TEAL.instance << 'dup2'
    end

    def ecdsa_pk_decompress(index, _input = nil)
      TEAL.instance << "ecdsa_pk_decompress #{index}"
    end

    def ecdsa_pk_recover(index, _input = nil)
      TEAL.instance << "ecdsa_pk_recover #{index}"
    end

    def ecdsa_verify(index, _input = nil)
      TEAL.instance << "ecdsa_verify #{index}"
    end

    def ed25519verify(_input = nil)
      TEAL.instance << 'ed25519verify'
    end

    def equal(_a = nil, _b = nil)
      TEAL.instance << '=='
    end

    def err
      TEAL.instance << 'err'
    end

    def exp(_a = nil, _b = nil)
      TEAL.instance << 'exp'
    end

    def expw(_a = nil, _b = nil)
      TEAL.instance << 'expw'
    end

    def extract(start, length, _byte_array = nil)
      TEAL.instance << "extract #{start} #{length}"
    end

    def extract3(_byte_array = nil, _start = nil, _exclusive_end = nil)
      TEAL.instance << 'extract3'
    end

    def extract_uint16(_byte_array = nil, _start = nil)
      TEAL.instance << 'extract_uint16'
    end

    def extract_uint32(_byte_array = nil, _start = nil)
      TEAL.instance << 'extract_uint32'
    end

    def extract_uint64(_byte_array = nil, _start = nil)
      TEAL.instance << 'extract_uint64'
    end

    def gaid(transaction_index)
      TEAL.instance << "gaid #{transaction_index}"
    end

    def gaids(_transaction = nil)
      TEAL.instance << 'gaids'
    end

    def getbit(_input = nil, _bit_index = nil)
      TEAL.instance << 'getbit'
    end

    def getbyte(_input = nil, _byte_index = nil)
      TEAL.instance << 'getbyte'
    end

    def gitxn(transaction_index, field)
      TEAL.instance << "gitxn #{transaction_index} #{field}"
    end

    def gitxna(transaction_index, field, index)
      TEAL.instance << "gitxna #{transaction_index} #{field} #{index}"
    end

    def gitxnas(transaction_index, field, _index = nil)
      TEAL.instance << "gitxnas #{transaction_index} #{field}"
    end

    def gload(transaction_index, index)
      TEAL.instance << "gload #{transaction_index} #{index}"
    end

    def gloads(index, _transaction_index = nil)
      TEAL.instance << "gloads #{index}"
    end

    def gloadss(_transaction = nil, _index = nil)
      TEAL.instance << 'gloadss'
    end

    def global(field)
      TEAL.instance << "global #{field}"
    end

    def greater(_a = nil, _b = nil)
      TEAL.instance << '>'
    end

    def greater_eq(_a = nil, _b = nil)
      TEAL.instance << '>='
    end

    def gtxn(index, field)
      TEAL.instance << "gtxn #{index} #{field}"
    end

    def gtxna(transaction_index, field, index)
      TEAL.instance << "gtxna #{transaction_index} #{field} #{index}"
    end

    def gtxns(field, _transaction_index = nil)
      TEAL.instance << "gtxns #{field}"
    end

    def gtxnsa(field, index, _transaction_index = nil)
      TEAL.instance << "gtxnsa #{field} #{index}"
    end

    def gtxnas(transaction_index, field, _index = nil)
      TEAL.instance << "gtxnas #{transaction_index} #{field}"
    end

    def gtxnsas(field, _transaction_index = nil, _index = nil)
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

    def itob(_bytes = nil)
      TEAL.instance << 'itob'
    end

    def itxn_begin
      TEAL.instance << 'itxn_begin'
    end

    def itxn_field(field, _value = nil)
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

    def itxnas(field, _index = nil)
      TEAL.instance << "itxnas #{field}"
    end

    def keccak256(_input = nil)
      TEAL.instance << 'keccak256'
    end

    def label(label_name)
      TEAL.instance << "#{label_name}:"
    end

    def len(_input = nil)
      TEAL.instance << 'len'
    end

    def less(_a = nil, _b = nil)
      TEAL.instance << '<'
    end

    def less_eq(_a = nil, _b = nil)
      TEAL.instance << '<='
    end

    def load(index)
      TEAL.instance << "load #{index}"
    end

    def loads(_index = nil)
      TEAL.instance << 'loads'
    end

    def log(_byte_array = nil)
      TEAL.instance << 'log'
    end

    def method_signature(signature)
      TEAL.instance << %(method "#{signature}")
    end

    def min_balance(_account = nil)
      TEAL.instance << 'min_balance'
    end

    def modulo(_a = nil, _b = nil)
      TEAL.instance << '%'
    end

    def multiply(_a = nil, _b = nil)
      TEAL.instance << '*'
    end

    def mulw(_a = nil, _b = nil)
      TEAL.instance << 'mulw'
    end

    def zero?(_expr = nil)
      TEAL.instance << '!'
    end

    def not_equal(_a = nil, _b = nil)
      TEAL.instance << '!='
    end

    def padded_bitwise_and(_a = nil, _b = nil)
      TEAL.instance << 'b&'
    end

    def padded_bitwise_or(_a = nil, _b = nil)
      TEAL.instance << 'b|'
    end

    def padded_bitwise_xor(_a = nil, _b = nil)
      TEAL.instance << 'b^'
    end

    def pop(_expr = nil)
      TEAL.instance << 'pop'
    end

    def pushbytes(string)
      TEAL.instance << "pushbytes \"#{string}\""
    end

    def pushint(integer)
      TEAL.instance << "pushint #{integer}"
    end

    def retsub
      TEAL.instance << 'retsub'
    end

    def select(_expr_a = nil, _expr_b = nil, _expr_c = nil)
      TEAL.instance << 'select'
    end

    def setbit(_input = nil, _bit_index = nil, _value = nil)
      TEAL.instance << 'setbit'
    end

    def setbyte(_byte_array = nil, _byte_index = nil, _value = nil)
      TEAL.instance << 'setbyte'
    end

    def sha256(_input = nil)
      TEAL.instance << 'sha256'
    end

    def sha512_256(_input = nil) # rubocop:disable Naming/VariableNumber
      TEAL.instance << 'sha512_256'
    end

    def shl(_a = nil, _b = nil)
      TEAL.instance << 'shl'
    end

    def shr(_a = nil, _b = nil)
      TEAL.instance << 'shr'
    end

    def sqrt(_integer = nil)
      TEAL.instance << 'sqrt'
    end

    def store(index, _value = nil)
      TEAL.instance << "store #{index}"
    end

    def stores(_index = nil, _value = nil)
      TEAL.instance << 'stores'
    end

    def substring(start, exclusive_end, _byte_array = nil)
      TEAL.instance << "substring #{start} #{exclusive_end}"
    end

    def substring3(_byte_array = nil, _start = nil, _exclusive_end = nil)
      TEAL.instance << 'substring3'
    end

    def subtract(_a = nil, _b = nil)
      TEAL.instance << '-'
    end

    def swap(_expr_a = nil, _expr_b = nil)
      TEAL.instance << 'swap'
    end

    def teal_return(_expr = nil)
      TEAL.instance << 'return'
    end

    def txn(field)
      TEAL.instance << "txn #{field}"
    end

    def txna(field, index)
      TEAL.instance << "txna #{field} #{index}"
    end

    def txnas(field, _index = nil)
      TEAL.instance << "txnas #{field}"
    end

    def uncover(count)
      TEAL.instance << "uncover #{count}"
    end

    def boolean_and(_a = nil, _b = nil)
      TEAL.instance << '&&'
    end

    def boolean_or(_a = nil, _b = nil)
      TEAL.instance << '||'
    end
  end
end
