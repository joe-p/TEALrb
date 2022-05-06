# frozen_string_literal: true

module TEALrb
  class Contract
    include TEALrb
    include Opcodes
    include Types
    include ABI
    include Rewriters

    attr_reader :teal

    class << self
      attr_accessor :subroutines, :version, :teal_methods, :abi_method_hash, :abi_description

      private

      def inherited(klass)
        klass.version = 6
        klass.subroutines = {}
        klass.teal_methods = {}
        klass.abi_description = ABI::ABIDescription.new
        klass.abi_method_hash = {}
        super
      end
    end

    # abi description for the method
    def self.abi(desc:, args:, returns:)
      args = args.map do |name, h|
        h[:name] = name.to_s
        h[:type] = h[:type].to_s.split('::').last.downcase
        h
      end

      self.abi_method_hash = { desc: desc, args: args, returns: returns.to_s.split('::').last.downcase }
    end

    # specifies a TEAL subroutine that will be defined upon intialization
    # @return [nil]
    # @overload subroutine(name)
    #  @param name [Symbol] name of the subroutine and the method to use as the subroutine definition
    #
    # @overload subroutine(name)
    #  @param name [Symbol] name of the subroutine
    #
    #  @yield [*args] the definition of the subroutine
    def self.subroutine(name, &blk)
      @subroutines[name] = (blk || instance_method(name))
      abi_description.add_method(**({ name: name.to_s }.merge abi_method_hash)) unless abi_method_hash.empty?
      @abi_method_hash = {}
      nil
    end

    # specifies a method to be defined upon intialization that will be transpiled to TEAL when called
    # @return [nil]
    # @overload subroutine(name)
    #  @param name [Symbol] name of the method to use as the TEAL definition
    #
    # @overload subroutine(name)
    #  @param name [Symbol] name of the method
    #
    #  @yield [*args] the definition of the TEAL method
    def self.teal(name, &blk)
      @teal_methods[name] = (blk || instance_method(name))
      nil
    end

    # sets the `#pragma version`, defines teal methods, and defines subroutines
    def initialize
      @teal = TEAL.new ["#pragma version #{self.class.version}"]

      self.class.subroutines.each do |name, blk|
        define_subroutine name, blk
      end

      self.class.teal_methods.each do |name, blk|
        define_teal_method name, blk
      end
    end

    # defines a method that is transpiled to TEAL
    # @param name [Symbol] name of the method
    # @param definition [Lambda, Proc, UnboundMethod] the method definition
    # @return [nil]
    def define_teal_method(name, definition)
      TEALrb.current_teal[Thread.current] = @teal

      new_source = rewrite(definition.source)
      new_source = rewrite_with_rewriter(new_source, MethodRewriter)

      pre_string = StringIO.new

      definition.parameters.reverse.each_with_index do |param, i|
        param_name = param.last
        pre_string.puts "store #{200 + i}"
        pre_string.puts "comment('#{param_name}', inline: true)"
        pre_string.puts "#{param_name} = -> { load #{200 + i}; comment('#{param_name}', inline: true) }"
      end

      new_source = "#{pre_string.string}#{new_source}"
      define_singleton_method(name) do |*_args|
        eval_tealrb(new_source)
      end

      nil
    end

    # defines a TEAL subroutine
    # @param name [Symbol] name of the method
    # @param definition [Lambda, Proc, UnboundMethod] the method definition
    # @return [nil]
    def define_subroutine(name, definition)
      TEALrb.current_teal[Thread.current] = @teal

      @teal << 'b main' unless @teal.include? 'b main'

      label(name) # add teal label

      comment_params = definition.parameters.map(&:last).join(', ')
      comment_content = "#{name}(#{comment_params})"
      comment(comment_content, inline: true)

      new_source = rewrite(definition.source)
      new_source = rewrite_with_rewriter(new_source, MethodRewriter)

      pre_string = StringIO.new

      definition.parameters.reverse.each_with_index do |param, i|
        param_name = param.last
        pre_string.puts "store #{200 + i}"
        pre_string.puts "comment('#{param_name}', inline: true)"
        pre_string.puts "#{param_name} = -> { load #{200 + i}; comment('#{param_name}', inline: true) }"
      end

      new_source = "#{pre_string.string}#{new_source}retsub"
      eval_tealrb(new_source)

      define_singleton_method(name) do |*_args|
        callsub(name)
      end

      nil
    end

    # insert comment into TEAL source
    # @param content [String] content of the comment
    # @param inline [Boolean] whether the comment should be on the previous TEAL line
    def comment(content, inline: false)
      if inline
        last_line = @teal.pop
        @teal << "#{last_line} // #{content}"
      else
        @teal << "// #{content}"
      end
    end

    # inserts a string into TEAL source
    # @param string [String] the string to insert
    def placeholder(string)
      @teal << string
    end

    # the hash of the abi description
    def abi_hash
      self.class.abi_description.to_h
    end

    # transpiles the given string to TEAL
    # @param string [String] string to transpile
    # @return [nil]
    def compile_string(string)
      TEALrb.current_teal[Thread.current] = @teal
      eval_tealrb(rewrite(string))
      nil
    end

    # transpiles #main
    def compile
      TEALrb.current_teal[Thread.current] = @teal
      @teal << 'main:' if @teal.include? 'b main'
      main_source = method(:main).source
      new_source = rewrite(main_source)
      eval_tealrb rewrite_with_rewriter(new_source, MethodRewriter)
    end

    private

    def rewrite_with_rewriter(string, rewriter)
      process_source = RuboCop::ProcessedSource.new(string, RUBY_VERSION[/\d\.\d/].to_f)
      rewriter.new.rewrite(process_source.buffer, process_source.ast)
    end

    def rewrite(string)
      [ComparisonRewriter, IfRewriter, OpRewriter, AssignRewriter].each do |rw|
        string = rewrite_with_rewriter(string, rw)
      end

      string
    end

    def eval_tealrb(s)
      eval s # rubocop:disable Security/Eval
    rescue SyntaxError, StandardError => e
      @eval_tealrb_rescue_count ||= 0

      eval_locations = e.backtrace.select {_1[/\(eval\)/]}
      error_line = eval_locations[@eval_tealrb_rescue_count].split(':')[1].to_i

      warn "'#{e}' when evaluating transpiled TEALrb source" if @eval_tealrb_rescue_count.zero?

      warn "Backtrace location (#{@eval_tealrb_rescue_count + 1} / #{eval_locations.size}):"

      @eval_tealrb_rescue_count += 1

      s.lines.each_with_index do |line, i|
        line_num = i + 1
        if error_line == line_num
          warn "=> #{line_num}: #{line}"
        else
          warn "   #{line_num}: #{line}"
        end
      end

      warn ''
      raise e
    end
  end
end
