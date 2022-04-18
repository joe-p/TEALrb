require 'method_source'
require 'ostruct'

require_relative 'constants'
require_relative 'abi'
require_relative 'expressions'
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
    include TEALrb::Opcodes::Binary
    include TEALrb::Opcodes::Unary

    def teal
      flatten
    end

    TEALrb::BINARY_METHODS.each do |meth, opcode|
      define_method(meth) do |other|
        send(opcode, self, other)
      end
    end

    TEALrb::UNARY_METHODS.each do |meth, opcode|
      define_method(meth) do
        send(opcode, self)
      end
    end
  end
end
