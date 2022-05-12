# frozen_string_literal: true

module TEALrb
  class Contract
    include TEALrb
    include Opcodes
    include ABI
    include Rewriters

    attr_reader :teal

    class << self
      attr_accessor :subroutines, :version, :teal_methods, :abi_method_hash, :abi_description, :debug

      private

      def inherited(klass)
        klass.version = 6
        klass.subroutines = {}
        klass.teal_methods = {}
        klass.abi_description = ABI::ABIDescription.new
        klass.abi_method_hash = {}
        klass.debug = false
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

      self.class.subroutines.each_key do |name|
        define_singleton_method(name) do |*_args|
          callsub(name)
        end
      end

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
      @teal.set_as_current

      new_source = rewrite(definition.source, method_rewriter: true)

      pre_string = StringIO.new

      definition.parameters.reverse.each_with_index do |param, i|
        param_name = param.last
        pre_string.puts "store #{200 + i}"
        pre_string.puts "comment('#{param_name}', inline: true)"
        pre_string.puts "#{param_name} = -> { load #{200 + i}; comment('#{param_name}', inline: true) }"
      end

      new_source = "#{pre_string.string}#{new_source}"
      define_singleton_method(name) do |*_args|
        eval_tealrb(new_source, debug_context: "teal method: #{name}")
      end

      nil
    end

    # defines a TEAL subroutine
    # @param name [Symbol] name of the method
    # @param definition [Lambda, Proc, UnboundMethod] the method definition
    # @return [nil]
    def define_subroutine(name, definition)
      @teal.set_as_current

      define_singleton_method(name) do |*_args|
        callsub(name)
      end

      @teal << 'b main' unless @teal.include? 'b main'

      label(name) # add teal label

      comment_params = definition.parameters.map(&:last).join(', ')
      comment_content = "#{name}(#{comment_params})"
      comment(comment_content, inline: true)

      new_source = rewrite(definition.source, method_rewriter: true)

      pre_string = StringIO.new

      definition.parameters.reverse.each_with_index do |param, i|
        param_name = param.last
        pre_string.puts "store #{200 + i}"
        pre_string.puts "comment('#{param_name}', inline: true)"
        pre_string.puts "#{param_name} = -> { load #{200 + i}; comment('#{param_name}', inline: true) }"
      end

      new_source = "#{pre_string.string}#{new_source}retsub"
      eval_tealrb(new_source, debug_context: "subroutine: #{name}")

      nil
    end

    # insert comment into TEAL source
    # @param content [String] content of the comment
    # @param inline [Boolean] whether the comment should be on the previous TEAL line
    def comment(content, inline: false)
      content = " #{content}" unless content[0] == ' '
      if inline
        last_line = @teal.pop
        @teal << "#{last_line} //#{content}"
      else
        @teal << "//#{content}"
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
      @teal.set_as_current
      eval_tealrb(rewrite(string), debug_context: 'compile_string')
      nil
    end

    # transpiles #main
    def compile
      @teal.set_as_current
      @teal << 'main:' if @teal.include? 'b main'
      eval_tealrb(rewrite(method(:main).source, method_rewriter: true), debug_context: 'main')
    end

    private

    def rewrite_with_rewriter(string, rewriter)
      process_source = RuboCop::ProcessedSource.new(string, RUBY_VERSION[/\d\.\d/].to_f)
      rewriter.new.rewrite(process_source)
    end

    def rewrite(string, method_rewriter: false)
      if self.class.debug
        puts 'DEBUG: Rewriting the following code:'
        puts string
        puts ''
      end

      [CommentRewriter, ComparisonRewriter, IfRewriter, OpRewriter, AssignRewriter].each do |rw|
        string = rewrite_with_rewriter(string, rw)
      end

      string = rewrite_with_rewriter(string, MethodRewriter) if method_rewriter

      if self.class.debug
        puts 'DEBUG: Resulting TEALrb code:'
        puts string
        puts ''
      end

      string
    end

    def eval_tealrb(s, debug_context:)
      pre_teal = Array.new @teal

      if self.class.debug
        puts "DEBUG: Evaluating the following code (#{debug_context}):"
        puts s
        puts ''
      end

      eval s # rubocop:disable Security/Eval

      if self.class.debug
        puts "DEBUG: Resulting TEAL (#{debug_context}):"
        puts Array.new(@teal) - pre_teal
        puts ''
      end
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
