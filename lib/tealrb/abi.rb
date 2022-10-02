# frozen_string_literal: true

require 'json'

module TEALrb
  module ABI
    def abi_return(_data)
      byte('151f7c75')
      concat
      log
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
