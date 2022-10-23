# frozen_string_literal: true

module TEALrb
  class Contract
    include TEALrb
    include Opcodes
    include Opcodes::AllOpcodes
    include ABI
    include Rewriters

    attr_reader :teal

    class << self
      attr_accessor :subroutines, :version, :teal_methods, :abi_interface, :debug,
                    :disable_abi_routing, :method_hashes, :src_map

      def inherited(klass)
        klass.version = 6
        klass.subroutines = {}
        klass.teal_methods = {}
        klass.abi_interface = ABI::ABIDescription.new
        klass.abi_interface.name = klass.to_s
        klass.method_hashes = []
        klass.debug = false
        klass.disable_abi_routing = false
        klass.src_map = true
        super
      end

      def parse(klass)
        YARD::Tags::Library.define_tag('ABI Method', :abi)
        YARD::Tags::Library.define_tag('Subroutine', :subroutine)
        YARD::Tags::Library.define_tag('TEAL Method', :teal)

        YARD.parse Object.const_source_location(klass.to_s).first

        YARD::Registry.all.each do |y|
          next unless y.type == :method
          next unless klass.instance_methods.include? y.name

          tags = y.tags.map(&:tag_name)

          if tags.include?('abi') || tags.include?('subroutine')
            method_hash = { name: y.name.to_s, desc: y.base_docstring, args: [], returns: { type: 'void' } }

            y.tags.each do |t|
              method_hash[:returns] = { type: t.types&.first&.downcase } if t.tag_name == 'return'

              next unless t.tag_name == 'param'

              method_hash[:args] << { name: t.name, type: t.types&.first&.downcase, desc: t.text }
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
      self.class.parse(self.class)

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
      TEAL.instance.compact.join("\n")
    end

    def generate_source_map(src)
      last_location = nil
      src_map_hash = {}

      src.each_line.with_index do |ln, i|
        if ln[/src_map:/]
          last_location = ln[/(?<=src_map:)\S+/]
          next
        end

        src_map_hash[i + 1] ||= { location: last_location } if last_location
      end

      compile_response = Algod.new.compile(src)

      case compile_response.status
      when 400
        msg = JSON.parse(compile_response.body)['message']
        puts 'Error(s) while attempting to compile TEAL:'
        msg.each_line do |ln|
          teal_line = ln.split(':').first.to_i
          ln_msg = ln.split(':')[1..].join(':').strip
          next if ln_msg == '"0"'

          puts "  #{teal_line} - #{src_map_hash[teal_line][:location]}: #{ln_msg}"
        end
      when 200
        json_body = JSON.parse(compile_response.body)
        pc_mapping = json_body['sourcemap']['mapping']

        pc_array = pc_mapping.split(';').map do |v|
          SourceMap::VLQ.decode_array(v)[2]
        end

        last_line = 1

        line_to_pc = {}
        pc_to_line = {}
        pc_array.each_with_index do |line_delta, pc|
          last_line += line_delta.to_i

          next if last_line == 1

          line_to_pc[last_line] ||= []
          line_to_pc[last_line] << pc
          pc_to_line[pc] = last_line
        end

        line_to_pc.each do |line, pcs|
          src_map_hash[line][:pcs] = pcs
        end
      end

      src_map_hash
    end

    def dump(directory = Dir.pwd, name: self.class.to_s.downcase, abi: true, src_map: true)
      src = formatted_teal

      File.write(File.join(directory, "#{name}.teal"), src)
      File.write(File.join(directory, "#{name}.abi.json"), JSON.pretty_generate(abi_hash)) if abi

      return unless src_map

      src_map_json = JSON.pretty_generate(generate_source_map(src))
      File.write(File.join(directory, "#{name}.src_map.json"), src_map_json)
    end

    def formatted_teal
      new_lines = []
      comments = []

      TEAL.instance.compact.each do |ln|
        ln = ln.strip

        next if ln.empty?

        if ln[/^#pragma/]
          new_lines << { text: ln, void: true, comments: comments }
          comments = []
        elsif ln[%r{^//}]
          comments << ln
        else
          op = ln.split.first
          new_lines << { text: ln, void: VOID_OPS.include?(op), comments: comments, label: ln[%r{\S+:($| //)}] }
          comments = []
        end
      end

      output = []
      under_label = false

      new_lines.each do |ln|
        output << '' if !output.last&.empty? && (ln[:label] || ln[:comments].any?)
        under_label = true if ln[:label]

        ln[:comments].each do |c|
          output << if ln[:label] || !under_label
                      c
                    else
                      "\t#{c}"
                    end
        end

        output << if ln[:label] || !under_label
                    ln[:text]
                  else
                    "\t#{ln[:text]}"
                  end

        output << '' if ln[:void] && !output.last.empty?
      end

      output.join("\n")
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

      unless TEAL.instance.include? 'b main'
        if self.class.src_map
          main_location = method(:main).source_location
          main_file = File.basename(main_location.first)
          main_line = main_location.last
          src_map(main_file, main_line)
        end

        TEAL.instance << 'b main'
      end

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
      return unless respond_to? :main

      eval_tealrb(
        rewrite(
          method(:main).source,
          method_rewriter: true,
          starting_location: method(:main).source_location
        ),
        debug_context: 'main'
      )
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
      new_source = rewrite(definition.source, method_rewriter: true, starting_location: method(name).source_location)

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
      new_source = rewrite(definition.source, method_rewriter: true, starting_location: definition.source_location)

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

          scratch_name = "#{definition.original_name}: #{param_name} [#{arg_types[i] || 'any'}] #{
            args[i][:desc] if args[i]}"
          scratch_names << scratch_name

          type = arg_types[i].downcase

          if txn_types.include? type
            pre_string.puts "@scratch['#{scratch_name}'] = Gtxns[Txn.group_index - int(#{txn_params})]"
            txn_params -= 1
          elsif type == 'application'
            pre_string.puts "@scratch['#{scratch_name}'] = Apps[#{app_param_index += 1}]"
          elsif type == 'asset'
            pre_string.puts "@scratch['#{scratch_name}'] = Assets[#{asset_param_index += 1}]"
          elsif type == 'account'
            pre_string.puts "@scratch['#{scratch_name}'] = Accounts[#{account_param_index += 1}]"
          elsif type == 'uint64'
            pre_string.puts "@scratch['#{scratch_name}'] = btoi(AppArgs[#{args_index += 1}])"
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

          scratch_name = "#{definition.original_name}: #{param_name} [#{arg_types[i] || 'any'}] #{
            args[i][:desc] if args[i]}"
          scratch_names << scratch_name

          type = arg_types[i]&.downcase

          if txn_types.include? type
            pre_string.puts "@scratch['#{scratch_name}'] = Gtxns"
          elsif type == 'application'
            pre_string.puts "@scratch['#{scratch_name}'] = Applications.new"
          elsif type == 'asset'
            pre_string.puts "@scratch['#{scratch_name}'] = Assets.new"
          elsif type == 'account'
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

    def rewrite(string, starting_location: nil, method_rewriter: false)
      if self.class.debug
        puts 'DEBUG: Rewriting the following code:'
        puts string
        puts ''
      end

      if starting_location && self.class.src_map
        multi_line = false

        string = string.lines.map.with_index do |ln, i|
          line_num = i + starting_location.last
          file = File.basename(starting_location.first)
          ln.strip!

          if ln[/^def /]
            method_name = ln.split[1].split('(').first.strip.to_sym
            yardoc = YARD::Registry.all.find { _1.name == method_name }

            unless yardoc.has_tag? 'teal'
              last_ln = TEAL.instance.pop
              src_map(file, line_num)
              TEAL.instance.push(last_ln)
            end
          elsif !multi_line && !ln.empty?
            ln = "\nsrc_map(rb('#{file}'),rb(#{line_num}))\n#{ln.strip}"
          end

          multi_line = if ln[/\\$/]
                         true
                       else
                         false
                       end

          "#{ln}\n"
        end.join
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

    def src_map(file, location)
      comment("src_map:#{file}:#{location}") unless TEAL.instance.empty?
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
