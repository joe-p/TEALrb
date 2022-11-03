# frozen_string_literal: true

module TEALrb
  class Contract
    include TEALrb
    include Opcodes::TEALOpcodes
    include MaybeOps
    include ByteOpcodes
    include ABI
    include Rewriters
    include Enums

    alias global_opcode global

    attr_reader :eval_location
    attr_accessor :teal, :if_count

    class << self
      attr_accessor :subroutines, :version, :abi_interface, :debug,
                    :disable_abi_routing, :method_hashes, :src_map

      def inherited(klass)
        klass.version = 6
        klass.subroutines = {}
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
        YARD::Tags::Library.define_tag('OnCompletes', :on_completion)
        YARD::Tags::Library.define_tag('Create', :create)

        YARD.parse Object.const_source_location(klass.to_s).first

        parsed_methods = {}
        YARD::Registry.all.each do |y|
          next unless y.type == :method
          next unless klass.instance_methods.include? y.name
          next if y.parent.type == :class && y.parent.to_s != klass.to_s

          if parsed_methods.keys.include? y.name
            raise "#{y.name} defined in two locations: \n  #{parsed_methods[y.name]}\n  #{y.file}:#{y.line}"
          end

          parsed_methods[y.name] = "#{y.file}:#{y.line}"

          tags = y.tags.map(&:tag_name)

          next unless tags.include?('abi') || tags.include?('subroutine')

          method_hash = { name: y.name.to_s, desc: y.base_docstring, args: [], returns: { type: 'void' },
                          on_completion: ['NoOp'], create: y.has_tag?('create') }

          y.tags.each do |t|
            method_hash[:returns] = { type: t.types&.first&.downcase } if t.tag_name == 'return'

            method_hash[:on_completion] = t.text[1..-2].split(',').map(&:strip) if t.tag_name == 'on_completion'
            next unless t.tag_name == 'param'

            method_hash[:args] << { name: t.name, type: t.types&.first&.downcase, desc: t.text }
          end

          klass.method_hashes << method_hash

          klass.abi_interface.add_method(**method_hash) if tags.include? 'abi'
        end
      end
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

    # sets the `#pragma version`, defines teal methods, and defines subroutines
    def initialize
      self.class.parse(self.class)

      @teal = TEAL.new ["#pragma version #{self.class.version}"], self
      @scratch = Scratch.new self

      @contract = self
      @if_count = -1

      self.class.method_hashes.each do |mh|
        define_subroutine(mh[:name], method(mh[:name]))
      end

      compile
    end

    VOID_OPS = %w[assert err return app_global_put b bnz bz store
                  stores app_local_put app_global_del app_local_del callsub retsub
                  log itxn_submit itxn_next].freeze

    def teal_source
      @teal.compact.join("\n")
    end

    def account(_account = nil)
      @account ||= Account.new self
    end

    alias accounts account

    def app(_app = nil)
      @app ||= App.new self
    end

    alias apps app

    def asset(_asset = nil)
      @asset ||= Asset.new self
    end

    alias assets asset

    def group_txn(_group_txn = nil)
      @group_txn ||= GroupTxn.new self
    end

    alias group_txns group_txn

    def global(field = nil, *_args)
      if field
        global_opcode(field)
      else
        @global ||= Global.new self
      end
    end

    def this_txn
      ThisTxn.new self
    end

    def box
      Box.new self
    end

    def inner_txn
      InnerTxn.new self
    end

    def logs
      Logs.new self
    end

    def app_args
      AppArgs.new self
    end

    def local
      Local.new self
    end

    def txn_type
      TxnType.new self
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
        e_msg = StringIO.new
        e_msg.puts 'Error(s) while attempting to compile TEAL'
        msg.each_line do |ln|
          teal_line = ln.split(':').first.to_i
          ln_msg = ln.split(':')[1..].join(':').strip
          next if ln_msg == '"0"'

          if src_map_hash[teal_line]
            e_msg.puts "  #{teal_line} - #{src_map_hash[teal_line][:location]}: #{ln_msg}"
          else
            e_msg.puts "  #{ln}"
          end
        end
        raise e_msg.string
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
          src_map_hash[line][:pcs] = pcs if src_map_hash[line]
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

      @teal.compact.each do |ln|
        ln = ln.strip

        next if ln.empty?

        if ln[/^#pragma/]
          new_lines << { text: ln, void: true, comments: comments }
          comments = []
        elsif ln[%r{^//}]
          comments << ln
        else
          op = ln.split.first
          new_lines << { text: ln, void: VOID_OPS.include?(op), comments: comments, label: ln[%r{\S+:($| //)}],
                         if_number: ln[/(?<=^if)\d+/], if_end: ln[/^if\d+_end/] }
          comments = []
        end
      end

      output = []
      indent_level = 0
      current_ifs = []

      new_lines.each do |ln|
        indent_level = 1 if ln[:label] && indent_level.zero?

        if ln[:if_number]
          indent_level += 1 unless current_ifs.include? ln[:if_number]
          current_ifs << ln[:if_number]
        end

        ln_indent_level = indent_level
        ln_indent_level -= 1 if ln[:label]

        output << '' if !output.last&.empty? && (ln[:label] || ln[:comments].any?)

        ln[:comments].each { output << (("\t" * ln_indent_level) + _1) }
        output << (("\t" * ln_indent_level) + ln[:text])

        output << '' if ln[:void] && !output.last.empty?

        if ln[:if_end]
          indent_level -= 1
          current_ifs.delete ln[:if_number]
        end
      end

      output.join("\n")
    end

    # return the input without transpiling to TEAL
    def rb(input)
      input
    end

    # defines a TEAL subroutine
    # @param name [Symbol] name of the method
    # @param definition [Lambda, Proc, UnboundMethod] the method definition
    # @return [nil]
    def define_subroutine(name, definition)
      return if method(name).source_location.first == __FILE__

      @eval_location = method(name).source_location

      define_singleton_method(name) do |*_args|
        callsub(name)
      end

      @teal << 'b main' unless @teal.include? 'b main'

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
      @teal << 'main:' if @teal.include? 'b main'
      route_abi_methods unless self.class.disable_abi_routing
      return unless respond_to? :main

      @eval_location = method(:main).source_location

      eval_tealrb(
        rewrite(
          method(:main).source,
          method_rewriter: true
        ),
        debug_context: 'main'
      )
    end

    def main
      nil
    end

    def compiled_program
      compile_response = Algod.new.compile(formatted_teal)

      generate_source_map(formatted_teal) if compile_response.status != 200

      JSON.parse(compile_response.body)['result']
    end

    private

    def route_abi_methods
      self.class.abi_interface.methods.each_with_index do |meth, i|
        signature = "#{meth[:name]}(#{meth[:args].map { _1[:type] }.join(',')})#{meth[:returns][:type]}"
        selector = OpenSSL::Digest.new('SHA512-256').hexdigest(signature)[..7]

        app_args[int(0)] == byte(selector) # rubocop:disable Lint/Void
        bz("abi_routing#{i}")
        callsub(meth[:name])
        approve
        label("abi_routing#{i}")
      end
    end

    def generate_method_source(name, definition)
      new_source = rewrite(definition.source, method_rewriter: true)

      pre_string = []

      scratch_names = []
      definition.parameters.reverse.each_with_index do |param, _i|
        param_name = param.first
        scratch_name = [name, param_name].map(&:to_s).join(': ')
        scratch_names << scratch_name

        pre_string << "@scratch.store('#{scratch_name}')"
        pre_string << "#{param_name} = -> { @scratch['#{scratch_name}'] }"
      end

      "#{pre_string.join(';')};#{new_source}"
    end

    def generate_subroutine_source(definition, method_hash)
      new_source = rewrite(definition.source, method_rewriter: true)

      pre_string = []

      scratch_names = []

      txn_types = %w[txn pay keyreg acfg axfer afrz appl]

      args = method_hash[:args] || []
      arg_types = args.map { _1[:type] } || []
      txn_params = arg_types.select { txn_types.include? _1 }.count
      app_param_index = -1
      asset_param_index = -1
      account_param_index = 0
      args_index = 0

      method_hash[:on_completion].each_with_index do |oc, i|
        this_txn.on_completion
        int(oc)
        equal
        boolean_or unless i.zero?
      end
      assert

      assert(this_txn.application_id == (int(0))) if method_hash[:create]

      if abi_hash['methods'].find { _1[:name] == method_hash[:name].to_s }
        definition.parameters.each_with_index do |param, i|
          param_name = param.last

          scratch_name = "#{definition.original_name}: #{param_name} [#{arg_types[i] || 'any'}] #{
            args[i][:desc] if args[i]}"
          scratch_names << scratch_name

          type = arg_types[i].downcase

          if txn_types.include? type
            @scratch[scratch_name] = group_txns[this_txn.group_index.subtract int(txn_params)]
            txn_params -= 1
          elsif type == 'application'
            @scratch[scratch_name] = apps[app_param_index += 1]
          elsif type == 'asset'
            @scratch[scratch_name] = assets[asset_param_index += 1]
          elsif type == 'account'
            @scratch[scratch_name] = accounts[account_param_index += 1]
          elsif type == 'uint64'
            @scratch[scratch_name] = btoi(app_args[args_index += 1])
          else
            @scratch[scratch_name] = app_args[args_index += 1]
          end

          pre_string << "#{param_name} = -> {@scratch['#{scratch_name}'] }"
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
            @scratch[scratch_name] = group_txn
          elsif type == 'application'
            @scratch[scratch_name] = application
          elsif type == 'asset'
            @scratch[scratch_name] = asset
          elsif type == 'account'
            @scratch[scratch_name] = account
          else
            @scratch.store(scratch_name)
          end

          pre_string << "#{param_name} = -> { @scratch['#{scratch_name}'] }"
        end

      end

      "#{pre_string.join(';')};#{new_source}"
    end

    def rewrite_with_rewriter(string, rewriter)
      process_source = RuboCop::ProcessedSource.new(string, RUBY_VERSION[/\d\.\d/].to_f)
      rewriter.new.rewrite(process_source, self)
    end

    def rewrite(string, method_rewriter: false)
      if self.class.debug
        puts 'DEBUG: Rewriting the following code:'
        puts string
        puts ''
      end

      [CommentRewriter, ComparisonRewriter, WhileRewriter, InlineIfRewriter, IfRewriter, OpRewriter,
       AssignRewriter].each do |rw|
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

      eval_locations = e.backtrace.select { _1[/\(eval\)/] }
      if eval_locations[@eval_tealrb_rescue_count]
        error_line = eval_locations[@eval_tealrb_rescue_count].split(':')[1].to_i
      end

      msg = "#{@eval_location.first}:#{error_line + @eval_location.last}"

      raise e, "#{msg}: #{e}"
    end
  end
end
