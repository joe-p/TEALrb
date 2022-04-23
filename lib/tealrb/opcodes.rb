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
      '&&': 'value_and',
      '||': 'value_or',
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
      '!': 'not'
    }.freeze

    def acct_params_get(field, account = nil)
      TEAL.new [account.teal, "acct_params_get #{field}"]
    end

    def add(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '+']
    end

    def addw(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'addw']
    end

    def app_global_del(key = nil)
      TEAL.new [key.teal, 'app_global_del']
    end

    def app_global_get(key = nil)
      TEAL.new [key.teal, 'app_global_get']
    end

    def app_global_get_ex(app = nil, key = nil)
      TEAL.new [app.teal, key.teal, 'app_global_get_ex']
    end

    def app_global_put(key = nil, value = nil)
      TEAL.new [key.teal, value.teal, 'app_global_put']
    end

    def app_local_del(account = nil, key = nil)
      TEAL.new [account.teal, key.teal, 'app_local_del']
    end

    def app_local_get(account = nil, key = nil)
      TEAL.new [account.teal, key.teal, 'app_local_get']
    end

    def app_local_get_ex(account = nil, application = nil, key = nil)
      TEAL.new [account.teal, application.teal, key.teal, 'app_local_get_ex']
    end

    def app_local_put(account = nil, key = nil, value = nil)
      TEAL.new [account.teal, key.teal, value.teal, 'app_local_put']
    end

    def app_opted_in(account = nil, app = nil)
      TEAL.new [account.teal, app.teal, 'app_opted_in']
    end

    def app_params_get(field, app_id = nil)
      TEAL.new [app_id.teal, "app_params_get #{field}"]
    end

    def approve
      TEAL.new [1.teal, 'return']
    end

    def arg(index)
      TEAL.new ["arg #{index}"]
    end

    def arg_0
      TEAL.new ['arg_0']
    end

    def arg_1
      TEAL.new ['arg_1']
    end

    def arg_2
      TEAL.new ['arg_2']
    end

    def arg_3
      TEAL.new ['arg_3']
    end

    def args(index = nil)
      TEAL.new [index.teal, 'args']
    end

    def assert(expr = nil)
      TEAL.new [expr.teal, 'assert']
    end

    def asset_holding_get(field, account = nil, asset = nil)
      TEAL.new [account.teal, asset.teal, "asset_holding_get #{field}"]
    end

    def asset_params_get(field, asset = nil)
      TEAL.new [asset.teal, "asset_params_get #{field}"]
    end

    def b(target)
      TEAL.new ["#{__method__} #{target}"]
    end

    def balance(account = nil)
      TEAL.new [account.teal, 'balance']
    end

    def big_endian_add(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b+']
    end

    def big_endian_divide(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b/']
    end

    def big_endian_equal(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b==']
    end

    def big_endian_less(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b<']
    end

    def big_endian_less_eq(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b<=']
    end

    def big_endian_modulo(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b%']
    end

    def big_endian_more(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b>']
    end

    def big_endian_more_eq(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b>=']
    end

    def big_endian_multiply(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b*']
    end

    def big_endian_not_equal(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b!=']
    end

    def big_endian_subtract(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b-']
    end

    def bitlen(input = nil)
      TEAL.new [input.teal, 'bitlen']
    end

    def bitwise_and(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '&']
    end

    def bitwise_byte_invert(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b~']
    end

    def bitwise_invert(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '~']
    end

    def bitwise_or(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '|']
    end

    def bitwise_xor(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '^']
    end

    def bnz(target)
      TEAL.new ["#{__method__} #{target}"]
    end

    def bsqrt(big_endian_uint = nil)
      TEAL.new [big_endian_uint.teal, 'bsqrt']
    end

    def btoi(bytes = nil)
      TEAL.new [bytes.teal, 'btoi']
    end

    def byte(string)
      TEAL.new ["byte \"#{string}\""]
    end

    def bytec(index)
      TEAL.new ["bytec #{index}"]
    end

    def bytec_0
      TEAL.new ['bytec_0']
    end

    def bytec_1
      TEAL.new ['bytec_1']
    end

    def bytec_2
      TEAL.new ['bytec_2']
    end

    def bytec_3
      TEAL.new ['bytec_3']
    end

    def bytecblock(*bytes)
      TEAL.new ["bytecblock #{bytes.join(' ')}"]
    end

    def bz(target)
      TEAL.new ["#{__method__} #{target}"]
    end

    def bzero(length = nil)
      TEAL.new [length.teal, 'bzero']
    end

    def callsub(name, *args)
      TEAL.new [args.map(&:teal), "callsub #{name}"].flatten
    end

    def concat(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'concat']
    end

    def cover(count)
      TEAL.new ["cover #{count}"]
    end

    def dig(index)
      TEAL.new ["dig #{index}"]
    end

    def divide(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '/']
    end

    def divmodw(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'divmodw']
    end

    def divw(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'divw']
    end

    def dup(expr = nil)
      TEAL.new [expr.teal, 'dup']
    end

    def dup2(expr_a = nil, expr_b = nil)
      TEAL.new [expr_a.teal, expr_b.teal, 'dup2']
    end

    def ecdsa_pk_decompress(index, input = nil)
      TEAL.new [input.teal, "ecdsa_pk_decompress #{index}"]
    end

    def ecdsa_pk_recover(index, input = nil)
      TEAL.new [input.teal, "ecdsa_pk_recover #{index}"]
    end

    def ecdsa_verify(index, input = nil)
      TEAL.new [input.teal, "ecdsa_verify #{index}"]
    end

    def ed25519verify(input = nil)
      TEAL.new [input.teal, 'ed25519verify']
    end

    def equal(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '==']
    end

    def err
      TEAL.new ['err']
    end

    def exp(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'exp']
    end

    def expw(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'expw']
    end

    def extract(start, length, byte_array = nil)
      TEAL.new [byte_array.teal, "extract #{start} #{length}"]
    end

    def extract3(byte_array = nil, start = nil, exclusive_end = nil)
      TEAL.new [byte_array.teal, start.teal, exclusive_end.teal, 'extract3']
    end

    def extract_uint16(byte_array = nil, start = nil)
      TEAL.new [byte_array.teal, start.teal, 'extract_uint16']
    end

    def extract_uint32(byte_array = nil, start = nil)
      TEAL.new [byte_array.teal, start.teal, 'extract_uint32']
    end

    def extract_uint64(byte_array = nil, start = nil)
      TEAL.new [byte_array.teal, start.teal, 'extract_uint64']
    end

    def gaid(transaction_index)
      TEAL.new ["gaid #{transaction_index}"]
    end

    def gaids(transaction = nil)
      TEAL.new [transaction.teal, 'gaids']
    end

    def getbit(input = nil, bit_index = nil)
      TEAL.new [input.teal, bit_index.teal, 'getbit']
    end

    def getbyte(input = nil, byte_index = nil)
      TEAL.new [input.teal, byte_index.teal, 'getbyte']
    end

    def gitxn(transaction_index, field)
      TEAL.new ["gitxn #{transaction_index} #{field}"]
    end

    def gitxna(transaction_index, field, index)
      TEAL.new ["gitxna #{transaction_index} #{field} #{index}"]
    end

    def gitxnas(transaction_index, field, index = nil)
      TEAL.new [index.teal, "gitxnas #{transaction_index} #{field}"]
    end

    def gload(transaction_index, index)
      TEAL.new ["gload #{transaction_index} #{index}"]
    end

    def gloads(index, transaction_index = nil)
      TEAL.new [transaction_index.teal, "gloads #{index}"]
    end

    def gloadss(transaction = nil, index = nil)
      TEAL.new [transaction.teal, index.teal, 'gloadss']
    end

    def global(field)
      TEAL.new ["global #{field}"]
    end

    def greater(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '>']
    end

    def greater_eq(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '>=']
    end

    def gtxn(index, field)
      TEAL.new ["gtxn #{index} #{field}"]
    end

    def gtxna(transaction_index, field, index)
      TEAL.new ["gtxna #{transaction_index} #{field} #{index}"]
    end

    def gtxns(field, transaction_index = nil)
      TEAL.new [transaction_index.teal, "gtxns #{field}"]
    end

    def gtxnsa(field, index, transaction_index = nil)
      TEAL.new [transaction_index.teal, "gtxna #{field} #{index}"]
    end

    def gtxnas(transaction_index, field, index = nil)
      TEAL.new [index.teal, "gtxnas #{transaction_index} #{field}"]
    end

    def gtxnsas(field, transaction_index = nil, index = nil)
      TEAL.new [transaction_index.teal, index.teal, "gtxnsas #{field}"]
    end

    def int(integer)
      TEAL.new ["int #{integer}"]
    end

    def intc(index)
      TEAL.new ["intc #{index}"]
    end

    def intc_0
      TEAL.new ['intc_0']
    end

    def intc_1
      TEAL.new ['intc_1']
    end

    def intc_2
      TEAL.new ['intc_2']
    end

    def intc_3
      TEAL.new ['intc_3']
    end

    def intcblock(*ints)
      TEAL.new ["intcblock #{ints.join(' ')}"]
    end

    def itob(bytes = nil)
      TEAL.new [bytes.teal, 'itob']
    end

    def itob(integer = nil)
      TEAL.new [integer.teal, 'itob']
    end

    def itxn_begin
      TEAL.new ['itxn_begin']
    end

    def itxn_field(field, value = nil)
      TEAL.new [value.teal, "itxn_field #{field}"]
    end

    def itxn_next
      TEAL.new ['itxn_next']
    end

    def itxn_submit
      TEAL.new ['itxn_submit']
    end

    def itxna(field, index)
      TEAL.new ["itxna #{field} #{index}"]
    end

    def itxnas(field, index = nil)
      TEAL.new [index.teal, "itxnas #{field}"]
    end

    def keccak256(input = nil)
      TEAL.new [input.teal, 'keccak256']
    end

    def len(input = nil)
      TEAL.new [input.teal, 'len']
    end

    def less(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '<']
    end

    def less_eq(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '<=']
    end

    def load(index)
      TEAL.new ["load #{index}"]
    end

    def loads(index = nil)
      TEAL.new [index.teal, 'loads']
    end

    def log(byte_array = nil)
      TEAL.new [byte_array.teal, 'log']
    end

    def log(data = nil)
      TEAL.new [data.teal, 'log']
    end

    def min_balance(account = nil)
      TEAL.new [account.teal, 'min_balance']
    end

    def modulo(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '%']
    end

    def multiply(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '*']
    end

    def mulw(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'mulw']
    end

    def not(expr = nil)
      TEAL.new [expr.teal, '!']
    end

    def not_equal(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '!=']
    end

    def padded_bitwise_and(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b&']
    end

    def padded_bitwise_or(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b|']
    end

    def padded_bitwise_xor(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'b^']
    end

    def pop(expr = nil)
      TEAL.new [expr.teal, 'pop']
    end

    def pushbytes(string)
      TEAL.new ["pushbytes \"#{string}\""]
    end

    def pushint(integer)
      TEAL.new ["pushint #{integer}"]
    end

    def retsub
      TEAL.new ['retsub']
    end

    def select(expr_a = nil, expr_b = nil, expr_c = nil)
      TEAL.new [expr_a.teal, expr_b.teal, expr_c.teal, 'select']
    end

    def setbit(input = nil, bit_index = nil, value = nil)
      TEAL.new [input.teal, bit_index.teal, value.teal, 'setbit']
    end

    def setbyte(byte_array = nil, byte_index = nil, value = nil)
      TEAL.new [byte_array.teal, byte_index.teal, value.teal, 'setbyte']
    end

    def sha256(input = nil)
      TEAL.new [input.teal, 'sha256']
    end

    def sha512_256(input = nil)
      TEAL.new [input.teal, 'sha512_256']
    end

    def shl(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'shl']
    end

    def shr(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, 'shr']
    end

    def sqrt(integer = nil)
      TEAL.new [integer.teal, 'sqrt']
    end

    def store(index, value = nil)
      TEAL.new [value.teal, "store #{index}"]
    end

    def stores(index = nil, value = nil)
      TEAL.new [index.teal, value.teal, 'stores']
    end

    def substring(start, exclusive_end, byte_array = nil)
      TEAL.new [byte_array.teal, "#{substring} #{start} #{exclusive_end}"]
    end

    def substring3(byte_array = nil, start = nil, exclusive_end = nil)
      TEAL.new [byte_array.teal, start.teal, exclusive_end.teal, 'substring3']
    end

    def subtract(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '-']
    end

    def swap(expr_a = nil, expr_b = nil)
      TEAL.new [expr_a.teal, expr_b.teal, 'swap']
    end

    def teal_return(expr = nil)
      TEAL.new [expr.teal, 'return']
    end

    def txn(field)
      TEAL.new ["txn #{field}"]
    end

    def txna(field, index)
      TEAL.new ["txna #{field} #{index}"]
    end

    def txnas(field, index = nil)
      TEAL.new [index.teal, "txnas #{field}"]
    end

    def uncover(count)
      TEAL.new ["uncover #{count}"]
    end

    def value_and(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '&&']
    end

    def value_or(a = nil, b = nil)
      TEAL.new [a.teal, b.teal, '||']
    end
  end
end
