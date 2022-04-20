# frozen_string_literal: true

module TEALrb
  module Opcodes
    module Unary
      OPCODE_METHOD_MAPPING = {
        '!': 'not'
      }.freeze

      def not(expr = nil)
        TEAL.new [expr.teal, '!']
      end
    end
  end
end
