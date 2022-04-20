# frozen_string_literal: true

require 'method_source'
require 'ostruct'

require_relative 'constants'
require_relative 'abi'
require_relative 'opcodes'
require_relative 'opcode_modules'
require_relative 'contract'
require_relative 'patches'

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
        Class.new.extend(TEALrb::Opcodes).send(opcode, self, other)
      end
    end

    TEALrb::Opcodes::UNARY_OPCODE_METHOD_MAPPING.each do |meth, opcode|
      define_method(meth) do
        Class.new.extend(TEALrb::Opcodes).send(opcode, self)
      end
    end
  end
end
