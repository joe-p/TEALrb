module TEALrb
  module Opcodes
    module Unorganized
      def len(input = nil)
        TEAL.new [input.teal, 'len']
      end

      def itob(integer = nil)
        TEAL.new [integer.teal, 'itob']
      end

      def mulw(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'mulw']
      end

      def addw(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'addw']
      end

      def divmodw(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'divmodw']
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

      def gaids(transaction = nil)
        TEAL.new [transaction.teal, 'gaids']
      end

      def loads(index = nil)
        TEAL.new [index.teal, 'loads']
      end

      def stores(index = nil, value = nil)
        TEAL.new [index.teal, value.teal, 'stores']
      end

      def pop(expr = nil)
        TEAL.new [expr.teal, 'pop']
      end

      def dup(expr = nil)
        TEAL.new [expr.teal, 'dup']
      end

      def dup2(expr_a = nil, expr_b = nil)
        TEAL.new [expr_a.teal, expr_b.teal, 'dup2']
      end

      def swap(expr_a = nil, expr_b = nil)
        TEAL.new [expr_a.teal, expr_b.teal, 'swap']
      end

      def select(expr_a = nil, expr_b = nil, expr_c = nil)
        TEAL.new [expr_a.teal, expr_b.teal, expr_c.teal, 'select']
      end

      def substring3(byte_array = nil, start = nil, exclusive_end = nil)
        TEAL.new [byte_array.teal, start.teal, exclusive_end.teal, 'substring3']
      end

      def getbit(input = nil, bit_index = nil)
        TEAL.new [input.teal, bit_index.teal, 'getbit']
      end

      def setbit(input = nil, bit_index = nil, value = nil)
        TEAL.new [input.teal, bit_index.teal, value.teal, 'setbit']
      end

      def getbyte(input = nil, byte_index = nil)
        TEAL.new [input.teal, byte_index.teal, 'getbyte']
      end

      def setbyte(byte_array = nil, byte_index = nil, value = nil)
        TEAL.new [byte_array.teal, byte_index.teal, value.teal, 'setbyte']
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

      def balance(account = nil)
        TEAL.new [account.teal, 'balance']
      end

      def app_local_get_ex(account = nil, application = nil, key = nil)
        TEAL.new [account.teal, application.teal, key.teal, 'app_local_get_ex']
      end

      def app_global_get_ex(app = nil, key = nil)
        TEAL.new [app.teal, key.teal, 'app_global_get_ex']
      end

      def app_local_put(account = nil, key = nil, value = nil)
        TEAL.new [account.teal, key.teal, value.teal, 'app_local_put']
      end

      def app_local_del(account = nil, key = nil)
        TEAL.new [account.teal, key.teal, 'app_local_del']
      end

      def app_global_del(key = nil)
        TEAL.new [key.teal, 'app_global_del']
      end

      def min_balance(account = nil)
        TEAL.new [account.teal, 'min_balance']
      end

      def retsub
        TEAL.new ['retsub']
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

      def bitlen(input = nil)
        TEAL.new [input.teal, 'bitlen']
      end

      def exp(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'exp']
      end

      def expw(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'expw']
      end

      def bsqrt(big_endian_uint = nil)
        TEAL.new [big_endian_uint.teal, 'bsqrt']
      end

      def divw(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'divw']
      end

      def bzero(length = nil)
        TEAL.new [length.teal, 'bzero']
      end

      def log(byte_array = nil)
        TEAL.new [byte_array.teal, 'log']
      end

      def itxn_next
        TEAL.new ['itxn_next']
      end

      def args(index = nil)
        TEAL.new [index.teal, 'args']
      end

      def gloadss(transaction = nil, index = nil)
        TEAL.new [transaction.teal, index.teal, 'gloadss']
      end

      def intc(index)
        TEAL.new ["intc #{index}"]
      end
      
      def bytec(index)
        TEAL.new ["bytec #{index}"]
      end
      
      def arg(index)
        TEAL.new ["arg #{index}"]
      end
      
      def gtxns(field, transaction_index = nil)
        TEAL.new [transaction_index.teal, "gtxns #{field}"]
      end
      
      def gloads(index, transaction_index = nil)
        TEAL.new [transaction_index.teal, "gloads #{index}"]
      end
      
      def gaid(transaction_index)
        TEAL.new ["gaid #{transaction_index}"]
      end
      
      def dig(index)
        TEAL.new ["dig #{index}"]
      end
      
      def cover(count)
        TEAL.new ["cover #{count}"]
      end
      
      def uncover(count)
        TEAL.new ["uncover #{count}"]
      end
      
      def asset_holding_get(field, account = nil, asset = nil)
        TEAL.new [account.teal, asset.teal, "asset_holding_get #{field}"]
      end
      
      def asset_params_get(field, asset = nil)
        TEAL.new [asset.teal, "asset_params_get #{field}"]
      end
      
      def app_params_get(field, asset = nil)
        TEAL.new [asset.teal, "app_params_get #{field}"]
      end
      
      def acct_params_get(field, account = nil)
        TEAL.new [account.teal, "acct_params_get #{field}"]
      end
      
      def txnas(field, index = nil)
        TEAL.new [index.teal, "txnas #{field}"]
      end
      
      def gtxnsas(field, transaction_index = nil, index = nil)
        TEAL.new [transaction_index.teal, index.teal, "gtxnsas #{field}"]
      end
      
      def itxnas(field, index = nil)
        TEAL.new [index.teal, "itxnas #{field}"]
      end
    end
  end
end
