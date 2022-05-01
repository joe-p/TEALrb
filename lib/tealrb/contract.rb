# frozen_string_literal: true

module TEALrb
  class IfBlock
    @@id = 0
    def initialize(teal, _cond, &blk)
      @teal = teal
      @else_count = 0
      @end_label = "if#{@id}_end:"

      @id = @@id
      @@id += 1

      @teal << "bz if#{@id}_else0"
      blk.call
      @teal << "b if#{@id}_end"
      @teal << "if#{@id}_else0:"
      @teal << @end_label
    end

    def elsif(_cond, &blk)
      @else_count += 1
      @teal.delete @end_label
      @teal << "bz if#{@id}_else#{@else_count}"
      blk.call
      @teal << "b if#{@id}_end"
      @teal << "if#{@id}_else#{@else_count}:"
      @teal << @end_label
      self
    end

    def else(&blk)
      @teal.delete @end_label
      blk.call
      @teal << @end_label
    end
  end

  class Contract
    include TEALrb
    include Opcodes
    include Types
    include ABI

    attr_reader :teal

    class << self
      attr_accessor :subroutines, :version, :teal_methods, :abi_method_hash, :abi_description
    end

    def self.inherited(klass)
      klass.version = 6
      klass.subroutines = []
      klass.teal_methods = []
      klass.abi_description = ABI::ABIDescription.new
      klass.abi_method_hash = {}
      super
    end

    def self.abi(desc:, args:, returns:)
      args = args.map do |name, h|
        h[:name] = name.to_s
        h[:type] = h[:type].to_s.split('::').last.downcase
        h
      end

      self.abi_method_hash = { desc: desc, args: args, returns: returns.to_s.split('::').last.downcase }
    end

    def self.subroutine(name)
      return if subroutines.include? name

      subroutines << name
      abi_description.add_method(**({ name: name.to_s }.merge abi_method_hash))
    end

    def self.teal(name)
      teal_methods << name unless teal_methods.include? name
    end

    def define_teal_method(name, source)
      new_source = rewrite(source)
      new_source = rewrite_with_rewriter(new_source, MethodRewriter)

      pre_string = StringIO.new

      method(name).parameters.map.with_index do |param, i|
        param_name = param.last
        pre_string.puts "store #{200 + i}"
        pre_string.puts "comment('#{param_name}', inline: true)"
        pre_string.puts "#{param_name} = -> { load #{200 + i}; comment('#{param_name}', inline: true) }"
      end

      new_source = "#{pre_string.string}#{new_source}"
      define_singleton_method(name) do |*_args|
        eval(new_source) # rubocop:disable Security/Eval
      end
    end

    def define_subroutine(name, source)
      TEALrb.current_teal[Thread.current] = @teal

      @teal << 'b main' unless @teal.include? 'b main'

      label(name) # add teal label

      comment_params = method(name).parameters.map(&:last).join(', ')
      comment_content = "#{name}(#{comment_params})"
      comment(comment_content, inline: true)

      new_source = rewrite(source)
      new_source = rewrite_with_rewriter(new_source, MethodRewriter)

      pre_string = StringIO.new

      method(name).parameters.map.with_index do |param, i|
        param_name = param.last
        pre_string.puts "store #{200 + i}"
        pre_string.puts "comment('#{param_name}', inline: true)"
        pre_string.puts "#{param_name} = -> { load #{200 + i}; comment('#{param_name}', inline: true) }"
      end

      new_source = "#{pre_string.string}#{new_source}retsub"
      eval(new_source) # rubocop:disable Security/Eval

      define_singleton_method(name) do |*_args|
        callsub(name)
      end
    end

    def comment(content, inline: false)
      if inline
        last_line = @teal.pop
        @teal << "#{last_line} // #{content}"
      else
        @teal << "// #{content}"
      end
    end

    def initialize
      @teal = TEAL.new ["#pragma version #{self.class.version}"]

      self.class.subroutines.each do |name|
        define_subroutine name, method(name).source
      end

      self.class.teal_methods.each do |name|
        define_teal_method name, method(name).source
      end
    end

    def placeholder(string)
      @teal << string
    end

    def abi_hash
      self.class.abi_description.to_h
    end

    def rewrite_with_rewriter(string, rewriter)
      buffer = Parser::Source::Buffer.new('(string)')
      buffer.source = string

      rewriter.new.rewrite(buffer, Parser::CurrentRuby.new.parse(buffer))
    end

    def rewrite(string)
      [ComparisonRewriter, IfRewriter, OpRewriter, AssignRewriter].each do |rw|
        string = rewrite_with_rewriter(string, rw)
      end

      puts '**** TEALrb ****'
      puts string
      puts '**** TEALrb ****'
      string
    end

    def compile_string(string)
      TEALrb.current_teal[Thread.current] = @teal
      eval(rewrite(string)) # rubocop:disable Security/Eval
    end

    def compile
      TEALrb.current_teal[Thread.current] = @teal
      @teal << 'main:' if @teal.include? 'b main'
      main_source = method(:main).source
      new_source = rewrite(main_source)
      self.class.class_eval(new_source)
      main
    rescue SyntaxError, StandardError => e
      line_num = e.backtrace.first.split(':')[1].to_i
      puts "EXCEPTION: #{new_source.lines[line_num - 1].strip}"
      raise e
    end
  end
end
