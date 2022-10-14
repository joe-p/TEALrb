# frozen_string_literal: true

module TEALrb
  class Contract
    include TEALrb
    include Opcodes
    include Opcodes::AllOpcodes
    include ABI
    include ABI::Types
    include Rewriters

    attr_reader :teal

    class << self
      attr_accessor :subroutines, :version, :teal_methods, :abi_interface, :debug,
                    :disable_abi_routing, :method_hashes

      private

      def inherited(klass)
        klass.version = 6
        klass.subroutines = {}
        klass.teal_methods = {}
        klass.abi_interface = ABI::ABIDescription.new
        klass.abi_interface.name = klass.to_s
        klass.method_hashes = []
        klass.debug = false
        klass.disable_abi_routing = false
        parse(klass)
        super
      end

      def parse(klass)
        YARD::Tags::Library.define_tag('ABI Method', :abi)
        YARD::Tags::Library.define_tag('Subroutine', :subroutine)
        YARD::Tags::Library.define_tag('TEAL Method', :teal)

        YARD.parse Object.const_source_location(klass.to_s).first

        YARD::Registry.all.each do |y|
          next unless y.type == :method
          next unless y.parent.to_s == klass.to_s

          tags = y.tags.map(&:tag_name)

          if tags.include?('abi') || tags.include?('subroutine')
            method_hash = { name: y.name.to_s, desc: y.base_docstring, args: [], returns: { type: 'void' } }

            y.tags.each do |t|
              method_hash[:returns] = { type: t.types&.first } if t.tag_name == 'return'

              next unless t.tag_name == 'param'

              method_hash[:args] << { name: t.name, type: t.types&.first, desc: t.text }
            end

            klass.method_hashes << method_hash

            klass.abi_interface.add_method(**method_hash) if tags.include? 'abi'
          elsif tags.include? 'teal'
            klass.teal_methods[y.name.to_s] = y
          end
        end
      end
    end

    # sets the `#pragma version`, defines teal methods, and defines subroutines
    def initialize
      @teal = TEAL.new ["#pragma version #{self.class.version}"]
      IfBlock.id = 0
      @scratch = Scratch.new

      @@active_contract = self # rubocop:disable Style/ClassVars

      self.class.method_hashes.each do |mh|
        define_subroutine(mh[:name], method(mh[:name]))
      end

      self.class.teal_methods.each do |name, definition|
        define_teal_method(name, definition)
      end
    end

    VOID_OPS = %w[assert err return app_global_put b bnz bz store
                  stores app_local_put app_global_del app_local_del callsub retsub
                  log itxn_submit itxn_next].freeze

    def teal_source
      teal_lines = []

      @teal.each_with_index do |line, i|
        ln = line.strip

        teal_lines << '' if i != 0 && VOID_OPS.include?(@teal[i - 1][/\S+/])

        if (ln[%r{\S+:($| //)}] && !ln[/^if\d+/]) || ln == 'b main' || ln[/^#/]
          teal_lines << ln
        elsif ln == 'retsub'
          teal_lines << "    #{ln}"
          teal_lines << ''
        else
          teal_lines << "    #{ln}"
        end
      end

      teal_lines.delete_if.with_index do |t, i|
        t.empty? && teal_lines[i - 1].empty?
      end

      teal_lines.join("\n")
    end

    # return the input without transpiling to TEAL
    def rb(input)
      input
    end

    # defines a method that is transpiled to TEAL
    # @param name [Symbol] name of the method
    # @param definition [Lambda, Proc, UnboundMethod] the method definition
    # @return [nil]
    def define_teal_method(name, definition)
      new_source = generate_method_source(name, definition)

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
      define_singleton_method(name) do |*_args|
        callsub(name)
      end

      TEAL.instance << 'b main' unless TEAL.instance.include? 'b main'

      label(name) # add teal label

      comment_params = definition.parameters.map(&:last).join(', ')
      comment_content = "#{name}(#{comment_params})"
      comment(comment_content, inline: true)

      method_hash = self.class.method_hashes.find { _1[:name] == name.to_s }
      new_source = generate_subroutine_source(definition, method_hash)

      new_source = "#{new_source}retsub"

      eval_tealrb(new_source, debug_context: "subroutine: #{name}")

      nil
    end

    # insert comment into TEAL source
    # @param content [String] content of the comment
    # @param inline [Boolean] whether the comment should be on the previous TEAL line
    def comment(content, inline: false)
      content = " #{content}" unless content[0] == ' '
      if inline
        last_line = TEAL.instance.pop
        TEAL.instance << "#{last_line} //#{content}"
      else
        TEAL.instance << '' unless TEAL.instance.last[%r{^//}]
        TEAL.instance << "//#{content}"
      end
    end

    # inserts a string into TEAL source
    # @param string [String] the string to insert
    def placeholder(string)
      TEAL.instance << string
    end

    # the hash of the abi description
    def abi_hash
      self.class.abi_interface.to_h
    end

    # transpiles the given string to TEAL
    # @param string [String] string to transpile
    # @return [nil]
    def compile_string(string)
      eval_tealrb(rewrite(string), debug_context: 'compile_string')
      nil
    end

    # transpiles #main and routes abi methods. To disable abi routing, set `@disable_abi_routing` to true in your
    # Contract subclass
    def compile
      TEAL.instance << 'main:' if TEAL.instance.include? 'b main'
      route_abi_methods unless self.class.disable_abi_routing
      eval_tealrb(rewrite(method(:main).source, method_rewriter: true), debug_context: 'main') if respond_to? :main
    end

    private

    def route_abi_methods
      self.class.abi_interface.methods.each do |meth|
        signature = "#{meth[:name]}(#{meth[:args].map { _1[:type] }.join(',')})#{meth[:returns][:type]}"
        selector = OpenSSL::Digest.new('SHA512-256').hexdigest(signature)[..7]

        IfBlock.new(AppArgs[0] == byte(selector)) do
          callsub(meth[:name])
          approve
        end
      end
    end

    def generate_method_source(name, definition)
      new_source = rewrite(definition.source, method_rewriter: true)

      pre_string = StringIO.new

      scratch_names = []
      definition.parameters.reverse.each_with_index do |param, _i|
        param_name = param.first
        scratch_name = [name, param_name].map(&:to_s).join(': ')
        scratch_names << scratch_name

        pre_string.puts "@scratch.store('#{scratch_name}')"
        pre_string.puts "#{param_name} = -> { @scratch['#{scratch_name}'] }"
      end

      "#{pre_string.string}#{new_source}"
    end

    def generate_subroutine_source(definition, method_hash)
      new_source = rewrite(definition.source, method_rewriter: true)

      pre_string = StringIO.new

      scratch_names = []

      txn_types = %w[txn pay keyreg acfg axfer afrz appl]

      args = method_hash[:args] || []
      arg_types = args.map { _1[:type] } || []
      txn_params = arg_types.select { txn_types.include? _1 }.count
      app_param_index = -1
      asset_param_index = -1
      account_param_index = 0
      args_index = 0

      if abi_hash['methods'].find { _1[:name] == method_hash[:name].to_s }
        definition.parameters.each_with_index do |param, i|
          param_name = param.last

          scratch_name = "#{definition.original_name}: #{param_name} [#{arg_types[i] || 'any'}] #{if args[i]
                                                                                                    args[i][:desc]
                                                                                                  end}"
          scratch_names << scratch_name

          if txn_types.include? arg_types[i]
            pre_string.puts "@scratch['#{scratch_name}'] = Gtxns[Txn.group_index - int(#{txn_params})]"
            txn_params -= 1
          elsif arg_types[i] == 'application'
            pre_string.puts "@scratch['#{scratch_name}'] = Apps[#{app_param_index += 1}]"
          elsif arg_types[i] == 'asset'
            pre_string.puts "@scratch['#{scratch_name}'] = Assets[#{asset_param_index += 1}]"
          elsif arg_types[i] == 'account'
            pre_string.puts "@scratch['#{scratch_name}'] = Accounts[#{account_param_index += 1}]"
          else
            pre_string.puts "@scratch['#{scratch_name}'] = AppArgs[#{args_index += 1}]"
          end

          pre_string.puts "#{param_name} = -> { @scratch['#{scratch_name}'] }"
        end

      else
        args.reverse!
        arg_types.reverse!

        definition.parameters.reverse.each_with_index do |param, i|
          param_name = param.last

          scratch_name = "#{definition.original_name}: #{param_name} [#{arg_types[i] || 'any'}] #{if args[i]
                                                                                                    args[i][:desc]
                                                                                                  end}"
          scratch_names << scratch_name

          if txn_types.include? arg_types[i]
            pre_string.puts "@scratch['#{scratch_name}'] = Gtxns"
          elsif arg_types[i] == 'application'
            pre_string.puts "@scratch['#{scratch_name}'] = Applications.new"
          elsif arg_types[i] == 'asset'
            pre_string.puts "@scratch['#{scratch_name}'] = Assets.new"
          elsif arg_types[i] == 'account'
            pre_string.puts "@scratch['#{scratch_name}'] = Accounts.new"
          else
            pre_string.puts "@scratch.store('#{scratch_name}')"
          end

          pre_string.puts "#{param_name} = -> { @scratch['#{scratch_name}'] }"
        end

      end

      "#{pre_string.string}#{new_source}"
    end

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

      [CommentRewriter, ComparisonRewriter, WhileRewriter, InlineIfRewriter, IfRewriter, OpRewriter,
       AssignRewriter, InternalMethodRewriter].each do |rw|
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
      pre_teal = Array.new TEAL.instance

      if self.class.debug
        puts "DEBUG: Evaluating the following code (#{debug_context}):"
        puts s
        puts ''
      end

      eval s # rubocop:disable Security/Eval

      if self.class.debug
        puts "DEBUG: Resulting TEAL (#{debug_context}):"
        puts Array.new(TEAL.instance) - pre_teal
        puts ''
      end
    rescue SyntaxError, StandardError => e
      @eval_tealrb_rescue_count ||= 0

      eval_locations = e.backtrace.select { _1[/\(eval\)/] }
      if eval_locations[@eval_tealrb_rescue_count]
        error_line = eval_locations[@eval_tealrb_rescue_count].split(':')[1].to_i
      end

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
