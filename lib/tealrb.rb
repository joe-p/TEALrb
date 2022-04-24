# frozen_string_literal: true

require 'method_source'
require 'ostruct'

require_relative 'tealrb/constants'
require_relative 'tealrb/types'
require_relative 'tealrb/abi'
require_relative 'tealrb/opcodes'
require_relative 'tealrb/opcode_modules'
require_relative 'tealrb/placeholder'
require_relative 'tealrb/contract'
require_relative 'tealrb/patches'
require_relative 'tealrb/cmd_line/teal2tealrb'

module TEALrb
  class If
    attr_accessor :blocks
    attr_reader :id

    def initialize(condition, id)
      @blocks = { condition => [] }
      @id = id
    end
  end

  class TEAL < Array
    def teal
      flatten
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
