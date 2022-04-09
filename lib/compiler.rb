module TEALrb
  class Compiler
    attr_reader :teal
    attr_accessor :vars, :subs

    def initialize
      @vars = OpenStruct.new
      @teal = ['b main']
      @if_count = 0
      @open_ifs = []
    end

    @@eval_location = "#{__FILE__}:#{__LINE__ + 2}"
    def teal_eval(str)
      eval(str).teal
    end

    def defsub(name, &blk)
      params = blk.parameters.map(&:last).map(&:to_s)
      @teal << name + ':'
      str = blk.source.lines[1..-2].join("\n")

      params.each_with_index do |name, i|
        @teal << "store #{201 + i}"
        str.gsub!(name, "load(#{201 + i})")
      end

      compile_string(str)

      @teal << 'retsub'
    end

    def compile(&blk)
      @open_ifs = []
      @teal << 'main:'
      compile_string(blk.source.lines[1..-2].join("\n"))
    end

    def compile_string(str)
      str.each_line do |line|
        line.strip!
        next if line.empty?

        # for if:
        #   bnz if1
        #   bnz if1_e1
        #   bnz if1_e2
        #   ... (this is the else block)
        #   b if1_end
        #   if1_e1:
        #     ...
        #     b if1_end
        #   if1_end:
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
          @teal += teal_eval(line)
        end
      end

      @teal = @teal.flatten.compact
      self
    end

    def new_if(conditional)
      @open_ifs << If.new(conditional, @if_count)
      @if_count += 1
    end

    def end_if
      current_if = @open_ifs.pop
      else_block = current_if.blocks.delete 'else'

      current_if.blocks.keys.each_with_index do |cond, i|
        @teal += teal_eval cond
        @teal << "bnz if#{current_if.id}_#{i}"
      end

      @teal << else_block.map { |str| teal_eval str } if else_block

      @teal << "b if#{current_if.id}_end"

      current_if.blocks.values.each_with_index do |block, i|
        @teal << "if#{current_if.id}_#{i}:"
        @teal += block.map { |str| teal_eval str }
        @teal << "b if#{current_if.id}_end"
      end

      @teal << "if#{current_if.id}_end:"
    end
  end
end
