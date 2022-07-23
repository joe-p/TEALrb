# frozen_string_literal: true

require 'json'

module TEALrb
  module ABI
    module Offchain
      def encode_fixed_array(data, type)
        val = ''

        data.each do |x|
          val += get_encoded(x, type)
        end

        val
      end

      def encode_variable_array(data, types)
        encode_uint(data.length, 16) + encode_fixed_array(data, types)
      end

      def encode_uint(data, bits)
        data_input = data
        data = data.to_i

        raise ArgumentError, "#{data_input} is not an integer" if data_input != data

        val = data.to_s(16)

        bytes = bits / 8

        raise ArgumentError, "#{data} is not a valid #{bits}-bit uint" if val.length > bytes

        val.rjust(bytes, '0')
      end

      def encode_ufixed(data, bits, precision)
        encode_uint(data * (10**precision), bits)
      end

      def encode_bool(data)
        (data ? 128 : 0).to_s(16)
      end

      def get_encoded(data, type, tuple_types = nil)
        type = type.to_s

        if type == 'bool'
          encode_bool(data)
        elsif type[/^uint/]
          bits = type[/(?<=uint)\d+/].to_i
          encode_uint(data, bits)
        elsif type[/^ufixed/]
          bits = type[/(?<=ufixed)\d+/].to_i
          precision = type[/(?<=x)\d+/].to_i
          encode_ufixed(data, bits, precision)
        elsif type == 'fixed_array'
          encode_fixed_array(data, tuple_types)
        elsif type == 'variable_array'
          encode_variable_array(data, tuple_types)
        end
      end

      def push_encoded(data, type, tuple_types = nil)
        @teal << "byte 0x#{get_encoded(data, type, tuple_types)}"
        comment("#{type}(#{data})", inline: true)
      end

      # TODO
      # encoding bools in tuple
      # encode_tuple(data, types)
    end

    module Onchain
      def abi_return(data)
        log(concat('151f7c75', data.teal).teal)
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
