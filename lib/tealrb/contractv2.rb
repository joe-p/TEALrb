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

  class ContractV2
    include TEALrb
    include Opcodes
    attr_reader :teal

    def initialize
      @teal = TEAL.new
    end

    def rewrite_with_rewriter(string, rewriter)
      buffer = Parser::Source::Buffer.new('(string)')
      buffer.source = string

      rewriter.new.rewrite(buffer, Parser::CurrentRuby.new.parse(buffer))
    end

    def rewrite(string)
      [IfRewriter, OpRewriter, AssignRewriter].each do |rw|
        string = rewrite_with_rewriter(string, rw)
      end

      puts "**** TEALrb ****"
      puts string
      puts "**** TEALrb ****"
      string
    end

    def compile_string(string)
      eval(rewrite(string))
    end

    def compile
      compile_string(method(:main).source.lines[1..-2].join)
    end
  end
end
