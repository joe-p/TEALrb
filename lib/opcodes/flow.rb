module TEALrb
  module Opcodes
    module Flow
      def approve
        TEAL.new [1.teal, 'return']
      end

      def err
        TEAL.new ['err']
      end

      def callsub(name, *args)
        TEAL.new [args.map(&:teal), "callsub #{name}"].flatten
      end

      def log(data = nil)
        TEAL.new [data.teal, 'log']
      end

      def assert(expr = nil)
        TEAL.new [expr.teal, 'assert']
      end

      def teal_return(expr = nil)
        TEAL.new [expr.teal, 'return']
      end

      def abi_return(data)
        log(concat('151f7c75', data.teal).teal)
      end
    end
  end
end
