# frozen_string_literal: true

require 'method_source'
require 'rubocop'

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
      attr_accessor :current
    end

    @current = {}

    def set_as_current
      self.class.current[Thread.current] = self
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
        ExtendedOpcodes.send(opcode, self, other)
      end
    end

    TEALrb::Opcodes::UNARY_OPCODE_METHOD_MAPPING.each do |meth, opcode|
      define_method(meth) do
        ExtendedOpcodes.send(opcode, self)
      end
    end
  end
end
