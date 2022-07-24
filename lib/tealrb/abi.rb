# frozen_string_literal: true

require 'json'

module TEALrb
  module ABI
    def abi_return(data)
      log(concat('151f7c75', data.teal).teal)
    end

    def abi_push(data)
      @teal << "byte 0x#{data.encoded}"
      data_string = data.value
      data_string = data.value.map(&:value) if data.value.is_a? Array

      comment("#{data.type_string}: #{data_string}", inline: true)
    end

    def encode_as(type)
      type.encode_from_stack
    end

    module Types
      class ABIType
        attr_accessor :type_string, :value, :encoded

        def initialize(value)
          @type_string ||= self.class.to_s.downcase.split('::').last # rubocop:disable Lint/DisjunctiveAssignmentInConstructor
          @value = value
          @encoded = encode
        end

        private

        def encode
          @value
        end
      end

      class Bool < ABIType
        extend TEALrb::Opcodes
        def self.encode_from_stack
          TEALrb::TEAL.current[Thread.current] << '// Encode bool from stack'
          IfBlock.new(TEALrb::TEAL.current[Thread.current], zero?) do
            byte '0x80', quote: false
          end.else do # rubocop:disable Style/MultilineBlockChain
            byte '0x00', quote: false
          end
        end

        def initialize(value)
          @type_string = 'bool'
          super(value)
        end

        private

        def encode
          (@value ? 128 : 0).to_s(16)
        end
      end

      class Uint < ABIType
        def initialize(value)
          @bits = self.class.to_s[/\d+/].to_i
          super(value)
        end

        private

        def encode
          enc = @value.to_s(16)

          bytes = @bits / 8

          raise ArgumentError, "#{data} is not a valid #{@bits}-bit uint" if enc.length > bytes

          enc.rjust(bytes, '0')
        end
      end

      class Ufixed < ABIType
        def initialize(value)
          @bits = self.class.to_s[/\d+(?=x)/].to_i
          @precision = self.class.to_s[/(?<=x)\d+/].to_i
          super(value)
        end

        private

        def encode
          enc = (@value * (10**@precision)).to_i.to_s(16)

          bytes = @bits / 8

          raise ArgumentError, "#{data} is not a valid #{@bits}-bit uint" if enc.length > bytes

          enc.rjust(bytes, '0')
        end
      end

      (8..512).each do |n|
        next unless (n % 8).zero?

        Object.const_set("Uint#{n}", Class.new(Uint))

        (1..160).each do |m|
          Object.const_set("Ufixed#{n}x#{m}", Class.new(Ufixed))
        end
      end

      class Tuple < ABIType
        def initialize(data)
          @type_string ||= "(#{data.map(&:type_string).join(', ')})" # rubocop:disable Lint/DisjunctiveAssignmentInConstructor

          super(data)
        end

        private

        # rubocop:disable Layout/LineLength
        # TODO: Encode bool
        # If Ti is bool:
        #   Let after be the largest integer such that all T(i+j) are bool, for 0 <= j <= after.
        #   Let before be the largest integer such that all T(i-j) are bool, for 0 <= j <= before.
        #   If before % 8 == 0:
        #     head(x[i]) = enc(x[i]) | (enc(x[i+1]) >> 1) | ... | (enc(x[i + min(after,7)]) >> min(after,7)), where >> is bitwise right shift which pads with 0, | is bitwise or, and min(x,y) returns the minimum value of the integers x and y.
        #     tail(x[i]) = "" (the empty string)
        #   Otherwise:
        #     head(x[i]) = "" (the empty string)
        #     tail(x[i]) = "" (the empty string)
        # rubocop:enable Layout/LineLength

        # TODO: Encode dynamic types
        # head(x[i]) = enc(len( head(x[1]) ... head(x[N]) tail(x[1]) ... tail(x[i-1]) ))
        # tail(x[i]) = enc(x[i])

        def encode
          val = { head: '', tail: '' }

          val[:head] += Uint16.new(@value.length).encoded if instance_of? FixedArray

          @value.each do |data|
            val[:head] += data.encoded
          end

          val[:head] + val[:tail]
        end
      end

      class FixedArray < Tuple
        def initialize(data)
          types = data.map(&:type_string).uniq

          raise 'FixedArray can only have one type' if types.size > 1

          @type_string = "#{types.first}[#{data.size}]"
          super
        end
      end

      class VariableArray < Tuple
        def initialize(data)
          types = data.map(&:type_string).uniq

          raise 'VariableArray can only have one type' if types.size > 1

          @type_string = "#{types.first}[]"
          super
        end
      end
    end

    class ABIDescription
      attr_accessor :name
      attr_reader :methods

      def initialize
        @name = ''
        @networks = {}
        @methods = []
      end

      def add_method(name:, desc:, args:, returns:)
        @methods << {
          name: name,
          desc: desc,
          args: args,
          returns: { type: returns }
        }
      end

      def add_id(network, id)
        @networks[network] = { appID: id }
      end

      def to_h
        {
          'name' => @name,
          'networks' => @networks,
          'methods' => @methods
        }
      end
    end
  end
end
