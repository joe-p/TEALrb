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

          if line[%r{^//}]
            line = %(comment("#{line.sub(%r{//}, '')}"))
            output.puts line
            next
          elsif line[%r{//.*}]
            comment = line[%r{(?<=//).*}]
            line.sub!(%r{//.*}, '')
            inline_comment = %(comment("#{comment}", inline: true))
          end

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

          output.puts line
          output.puts inline_comment if inline_comment
        end

        output.string
      end
    end
  end
end
