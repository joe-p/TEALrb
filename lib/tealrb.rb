# frozen_string_literal: true

require 'method_source'
require 'rubocop'
require 'yard'
require 'faraday'
require 'source_map'

require_relative 'tealrb/constants'
require_relative 'tealrb/abi'
require_relative 'tealrb/opcodes'
require_relative 'tealrb/maybe_ops'
require_relative 'tealrb/byte_opcodes'
require_relative 'tealrb/txn_fields'
require_relative 'tealrb/opcode_type'
require_relative 'tealrb/account'
require_relative 'tealrb/this_txn'
require_relative 'tealrb/box'
require_relative 'tealrb/inner_txn'
require_relative 'tealrb/group_txn'
require_relative 'tealrb/global'
require_relative 'tealrb/app'
require_relative 'tealrb/asset'
require_relative 'tealrb/logs'
require_relative 'tealrb/app_args'
require_relative 'tealrb/local'
require_relative 'tealrb/enums'
require_relative 'tealrb/scratch'
require_relative 'tealrb/algod'
require_relative 'tealrb/rewriters'
require_relative 'tealrb/contract'
require_relative 'tealrb/cmd_line/teal2tealrb'

module TEALrb
  class TEAL < Array
    def initialize(teal_array, contract)
      @contract = contract
      super(teal_array)
    end

    def teal
      flatten
    end

    def boolean_and(_other)
      self << '&&'
    end

    def <<(value)
      return super unless @contract.class.src_map
      return super if caller.join['src_map']
      return super unless @contract.eval_location

      eval_location = caller.reverse.find { _1[/^\(eval/] }&.split(':')
      return super unless eval_location

      eval_line = eval_location[1].to_i
      src_map(@contract.eval_location.first, @contract.eval_location.last + eval_line)
      super
    end

    def src_map(file, line_number)
      ln = "// src_map:#{File.basename(file)}:#{line_number}"
      return if ln == @last_src_map

      @last_src_map = ln

      self << ln
    end

    def boolean_or(_other)
      self << '||'
    end

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
  end
end
