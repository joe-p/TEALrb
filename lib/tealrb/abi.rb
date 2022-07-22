# frozen_string_literal: true

require 'json'

module TEALrb
  module ABI
    def abi_return(data)
      log(concat('151f7c75', data.teal).teal)
    end

    # TODO
    # encode_array(data, type)
    # encode_tuple(data, types)

    def encode_uint(data, bits)
      data_input = data
      data = data.to_i

      raise ArgumentError, "#{data_input} is not an integer" if data_input != data

      val = data.to_s(16)

      raise ArgumentError, "#{data} is not a valid #{bits}-bit uint" if val.length > bits

      val.rjust(bits / 8, '0')
    end

    def encode_ufixed(data, bits, precision)
      encode_uint(data * (10**precision), bits)
    end

    def encode_bool(data)
      (data ? 128 : 0).to_s(16)
    end

    def push_encoded(data, type)
      type = type.to_s

      val = if type == 'bool'
              encode_bool(data)
            elsif type[/^uint/]
              bits = type[/(?<=uint)\d+/].to_i
              encode_uint(data, bits)
            elsif type[/^ufixed/]
              bits = type[/(?<=ufixed)\d+/].to_i
              precision = type[/(?<=x)\d+/].to_i
              encode_ufixed(data, bits, precision)
            end

      @teal << "byte 0x#{val}"
      comment("#{type}(#{data})", inline: true)
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
