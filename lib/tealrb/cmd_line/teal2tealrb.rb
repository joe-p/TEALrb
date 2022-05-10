# frozen_string_literal: true

require 'stringio'
module TEALrb
  module CmdLine
    module TEAL2TEALrb
      def self.convert(input)
        output = StringIO.new

        input.each_line do |line|
          line.strip!
          next if line[/^#/]

          comment = line[%r{//.*}]
          comment&.sub!('//', '# //')
          line.sub!(%r{//.*}, '')

          opcode = line.split.first

          opcode_mappings = TEALrb::Opcodes::BINARY_OPCODE_METHOD_MAPPING
          opcode_mappings.merge TEALrb::Opcodes::UNARY_OPCODE_METHOD_MAPPING

          opcode_mappings.each do |op, method|
            line.sub!(opcode, method) if opcode == op.to_s
          end

          if line[/^(b|bz|bnz|callsub) /]
            label = line.split.last
            line.gsub!(label, ":#{label}")
          elsif line[/\w+:/]
            line = ":#{line[0..-2]}"
          elsif opcode == 'return'
            line = 'teal_return'
          elsif opcode == 'method'
            line.sub!('method', 'method_signature')
          end

          if line.count(' ').positive? && !%w[byte pushbytes method].include?(opcode)
            args = line.split[1..]
            args.map! do |arg|
              arg_as_int = Integer(arg, exception: false)
              if arg[/^:/]
                arg
              else
                arg_as_int || "'#{arg}'"
              end
            end

            line = "#{opcode} #{args.join(', ')}"
          end

          if line.empty?
            output.puts comment
          else
            output.puts "#{line} #{comment}"
          end
        end

        output.string
      end
    end
  end
end
