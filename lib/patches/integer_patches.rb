module TEALrb
  module Patches
    module IntegerMethods
      include TEALrb::Opcodes::Types
      include TEALrb::Opcodes::Binary
      include TEALrb::Opcodes::Unary

      def teal
        int(self).teal
      end

      TEALrb::Opcodes::Binary::OPCODE_METHOD_MAPPING.each do |meth, opcode|
        define_method(meth) do |other|
          from_eval = (caller[0] + caller[2]).include? "`teal_eval'"

          if from_eval
            send(opcode, self, other)
          else
            super(other)
          end
        end
      end

      TEALrb::Opcodes::Unary::OPCODE_METHOD_MAPPING.each do |meth, klass|
        define_method(meth) do
          from_eval = caller[0].include? "(eval):1:in `teal_eval'"

          if from_eval
            send(opcode, self)
          else
            super()
          end
        end
      end
    end
  end
end

class Integer
  prepend TEALrb::Patches::IntegerMethods
end
