# frozen_string_literal: true

module TEALrb
  module Patches
    module IntegerMethods
      include TEALrb::Opcodes

      def teal
        int(self).teal
      end

      TEALrb::Opcodes::BINARY_OPCODE_METHOD_MAPPING.each do |meth, opcode|
        define_method(meth) do |other|
          from_eval = (caller[0] + caller[2]).include? "`teal_eval'"

          if from_eval
            send(opcode, self, other)
          else
            super(other)
          end
        end
      end

      TEALrb::Opcodes::UNARY_OPCODE_METHOD_MAPPING.each do |meth, _klass|
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
