# frozen_string_literal: true

module TEALrb
  class Contract
    include TEALrb
    include TEALrb::Opcodes
    extend ABI::ABITypes

    @@subroutines = []
    @@teal_methods = []
    @@abi_method_hash = nil
    @@version = 6

    @@abi = ABI::ABIDescription.new

    def self.abi(desc:, args:, returns:)
      args = args.map do |name, h|
        h[:name] = name.to_s
        h[:type] = h[:type].to_s
        h
      end
      @@abi_method_hash = { desc: desc, args: args, returns: returns.to_s }
    end

    def initialize()
      @teal = ["#pragma version #{@@version}", 'b main']
      @if_count = 0
      @open_ifs = []
      @default_binding = binding

      @@subroutines.each do |sub|
        define_subroutine(sub, &method(sub))
      end

      @@teal_methods.each do |meth|
        define_teal_method(meth, &method(meth))
      end
    end

    def teal
      @teal.join("\n")
    end

    def teal_eval(str, eval_binding = @default_binding)
      result = eval_binding.eval(str)

      return nil if str[/^@*[a-z_][a-zA-Z_0-9]* =/] # variable assignment

      result.teal
    rescue StandardError, SyntaxError => e
      puts "TEAL EVAL ERROR: #{str}"
      raise e
    end

    def self.subroutine(method)
      @@subroutines << method
      @@abi.add_method(**({ name: method.to_s }.merge @@abi_method_hash))
    end

    def self.teal(method)
      @@teal_methods << method
    end

    def define_teal_method(name, &blk)
      define_singleton_method(name) do |*_args|
        compile(&blk)
      end
    end

    def define_subroutine(name, &blk)
      params = blk.parameters.map(&:last).map(&:to_s)
      @sub_name = name

      define_singleton_method(name) do |*args|
        @sub_args = args

        compile do
          callsub(@sub_name, *@sub_args)
        end
      end

      @teal << ("#{name}:")
      str = blk.source.lines[1..-2].join("\n")

      params.each_with_index do |name, i|
        @teal << "store #{201 + i}"
        compile("#{name} = load(#{201 + i})")
      end

      compile(str)

      @teal << 'retsub'
    end

    def main(str = nil, &blk)
      @teal << 'main:'
      compile(str, &blk)
    end

    def compile(str = nil, &blk)
      @open_ifs ||= []

      if str
        compile_string(str)
      else
        compile_block(&blk)
      end
    end

    def compile_block(eval_binding = @default_binding, &blk)
      compile_string(blk.source.lines[1..-2].join("\n"), eval_binding)
    end

    def compile_string(str, eval_binding = @default_binding)
      str.each_line do |line|
        line.strip!
        next if line.empty?
        next if line[/^#/]

        line.gsub!(/unless .*/, "if !(#{line[/(?<=unless ).*/]})") if line[/^unless /] || line[/ unless /]

        if line[/^if /]
          new_if(line[/(?<=if ).*/])
        elsif line == 'else'
          @open_ifs.last.blocks['else'] = []
        elsif line[/^elsif/]
          @open_ifs.last.blocks[line[/(?<=elsif ).*/]] = []
        elsif line == 'end'
          end_if
        elsif line[/ if /]
          new_if(line[/(?<=if ).*/])
          @open_ifs.last.blocks.values.last << line[/.*(?= if)/]
          end_if
        elsif !@open_ifs.empty?
          @open_ifs.last.blocks.values.last << line
        else
          @teal << teal_eval(line, eval_binding)
        end
      end

      @teal = @teal.flatten.compact
      self
    end

    def new_if(conditional)
      @open_ifs << If.new(conditional, @if_count)
      @if_count += 1
    end

    def end_if(eval_binding = @default_binding)
      current_if = @open_ifs.pop
      else_block = current_if.blocks.delete 'else'

      current_if.blocks.keys.each_with_index do |cond, i|
        @teal << teal_eval(cond, eval_binding)
        @teal << "bnz if#{current_if.id}_#{i}"
      end

      @teal << else_block.map { |str| teal_eval(str, eval_binding) } if else_block

      @teal << "b if#{current_if.id}_end"

      current_if.blocks.values.each_with_index do |block, i|
        @teal << "if#{current_if.id}_#{i}:"
        @teal << block.map { |str| teal_eval(str, eval_binding) }
        @teal << "b if#{current_if.id}_end"
      end

      @teal << "if#{current_if.id}_end:"
    end

    def main
      err
    end

    def compile_main
      @teal << 'main:'
      compile_block(&method(:main))
    end

    def abi_hash
      @@abi.to_h
    end
  end
end
