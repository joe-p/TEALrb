# frozen_string_literal: true

module TEALrb
  module Opcodes
    module Binary
      OPCODE_METHOD_MAPPING = {
        '+': 'add',
        '-': 'subtract',
        '<': 'less',
        '>': 'greater',
        '<=': 'less_eq',
        '>=': 'greater_eq',
        '/': 'divide',
        '==': 'equal',
        '&': 'bitwise_and',
        '!=': 'not_equal',
        '*': 'multiply',
        '&&': 'value_and',
        '||': 'value_or',
        '%': 'modulo',
        '|': 'bitwise_or',
        '^': 'bitwise_xor',
        '~': 'bitwise_invert',
        'b+': 'big_endian_add',
        'b-': 'big_endian_subtract',
        'b/': 'big_endian_divide',
        'b*': 'big_endian_multiply',
        'b<': 'big_endian_less',
        'b>': 'big_endian_more',
        'b<=': 'big_endian_less_eq',
        'b>=': 'big_endian_more_eq',
        'b==': 'big_endian_equal',
        'b!=': 'big_endian_not_equal',
        'b%': 'big_endian_modulo',
        'b|': 'padded_bitwise_or',
        'b&': 'padded_bitwise_and',
        'b^': 'padded_bitwise_xor',
        'b~': 'bitwise_byte_invert'
      }.freeze
      def big_endian_more(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b>']
      end

      def big_endian_less_eq(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b<=']
      end

      def big_endian_more_eq(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b>=']
      end

      def big_endian_equal(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b==']
      end

      def big_endian_not_equal(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b!=']
      end

      def big_endian_modulo(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b%']
      end

      def padded_bitwise_or(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b|']
      end

      def padded_bitwise_and(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b&']
      end

      def padded_bitwise_xor(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b^']
      end

      def bitwise_byte_invert(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b~']
      end

      def big_endian_less(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b<']
      end

      def big_endian_multiply(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b*']
      end

      def big_endian_divide(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b/']
      end

      def big_endian_subtract(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b-']
      end

      def big_endian_add(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, 'b+']
      end

      def bitwise_invert(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '~']
      end

      def bitwise_xor(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '^']
      end

      def bitwise_or(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '|']
      end

      def modulo(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '%']
      end

      def value_or(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '||']
      end

      def value_and(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '&&']
      end

      def add(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '+']
      end

      def subtract(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '-']
      end

      def divide(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '/']
      end

      def multiply(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '*']
      end

      def less(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '<']
      end

      def greater(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '>']
      end

      def less_eq(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '<=']
      end

      def greater_eq(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '>=']
      end

      def equal(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '==']
      end

      def not_equal(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '!=']
      end

      def bitwise_and(a = nil, b = nil)
        TEAL.new [a.teal, b.teal, '&']
      end
    end
  end
end
