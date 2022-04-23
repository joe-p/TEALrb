# frozen_string_literal: true

require 'json'

module TEALrb
  module ABI
=begin
      (8..512).step(8) do |n|
        (0..160).each do |m|
          type = "ufixed#{n}x#{m}"

          define_method(type) do
            ABIType.new type
          end
        end
      end

      (8..512).step(8) do |n|
        type = "uint#{n}"

        define_method(type) do
          ABIType.new type
        end
      end
    end
=end
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
