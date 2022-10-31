module TEALrb
  class OpcodeType
    TEALrb::Opcodes::BINARY_OPCODE_METHOD_MAPPING.each do |meth, opcode|
      define_method(meth) do |other|
        @contract.send(opcode, self, other)
      end
    end

    TEALrb::Opcodes::UNARY_OPCODE_METHOD_MAPPING.each do |meth, opcode|
      define_method(meth) do
        @contract.send(opcode, self)
      end
    end

    def initialize(contract)
      @contract = contract
    end
  end
end
