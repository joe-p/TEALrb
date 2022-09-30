# frozen_string_literal: true

require 'method_source'
require 'rubocop'
require 'yard'

require_relative 'tealrb/constants'
require_relative 'tealrb/abi'
require_relative 'tealrb/opcodes'
require_relative 'tealrb/opcode_modules'
require_relative 'tealrb/rewriters'
require_relative 'tealrb/if_block'
require_relative 'tealrb/scratch'
require_relative 'tealrb/contract'
require_relative 'tealrb/cmd_line/teal2tealrb'

module TEALrb
  class TEAL < Array
    class << self
      attr_writer :instance

      def instance
        raise 'TEALrb does not support multi-threading' if Thread.current != Thread.main

        @instance
      end
    end

    def initialize(teal_array)
      self.class.instance = self
      super
    end

    def teal
      flatten
    end

    def boolean_and(_other)
      self << '&&'
    end

    def boolean_or(_other)
      self << '||'
    end

    TEALrb::Opcodes::BINARY_OPCODE_METHOD_MAPPING.each do |meth, opcode|
      define_method(meth) do |other|
        TEALrb::Opcodes::ExtendedOpcodes.send(opcode, self, other)
      end
    end

    TEALrb::Opcodes::UNARY_OPCODE_METHOD_MAPPING.each do |meth, opcode|
      define_method(meth) do
        TEALrb::Opcodes::ExtendedOpcodes.send(opcode, self)
      end
    end
  end
end
