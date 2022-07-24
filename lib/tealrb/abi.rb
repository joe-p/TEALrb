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

    module Types
      class ABIType
        attr_accessor :type_string, :value, :encoded

        def initialize(value)
          @value = value
          @encoded = encode
        end

        private

        def encode
          @value
        end
      end

      class Bool < ABIType
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
        def initialize(bits:, value:)
          @type_string = "uint#{bits}"
          @bits = bits
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
        def initialize(bits:, precision:, value:)
          @type_string = "ufixed#{bits}x#{precision}"
          @bits = bits
          @precision = precision
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

      class Tuple < ABIType
        def initialize(data)
          @type_string ||= "(#{data.map(&:type_string).join(', ')})" # rubocop:disable Lint/DisjunctiveAssignmentInConstructor

          super(data)
        end

        private

        # TODO
        #   - Encode bool
        #   - Encode dynamic types
        def encode
          val = { head: '', tail: '' }

          val[:head] += Uint.new(bits: 16, value: @value.length).encoded if instance_of? FixedArray

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
