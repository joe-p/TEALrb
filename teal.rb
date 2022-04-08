require 'pry'
require 'method_source'

class String
  def teal
    TEALrb::Bytes.new(self).teal
  end
end

module TEALrb
  class Expression
    attr_reader :teal

    def +(other)
      add self, other
    end
  end

  class Int < Expression
    def initialize(integer)
      @teal = ["int #{integer}"]
    end
  end

  class Bytes < Expression
    def initialize(string)
      @teal = ["bytes \"#{string}\""]
    end
  end

  class AppGlobalGet < Expression
    def initialize(key)
      @teal = [key.teal, 'app_global_get']
    end
  end

  def app_global_get(key = nil)
    AppGlobalGet.new(key)
  end

  class Add < Expression
    def initialize(a, b)
      @teal = [a.teal, b.teal, '+']
    end
  end

  def add(a = nil, b = nil)
    Add.new a, b
  end

  class If
    attr_accessor :blocks
    attr_reader :id

    def initialize(condition, id)
      @blocks = {condition => []}
      @id = id
    end
  end

  class Compiler
    attr_reader :teal, :vars

    def initialize(vars)
      @vars = vars
      @teal = []
      @if_count = 0
      @open_ifs = 0
    end

    @@eval_location = "#{__FILE__}:#{__LINE__ + 2}"
    def teal_eval(str)
      eval("(#{str}).teal")
    end

    def compile(&blk)
      @open_ifs = []

      blk.source.lines[1..-2].each do |line|
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
          nil
        elsif line == 'end'
          end_if
        elsif line[/ if /]
          new_if(line[/(?<=if ).*/])
          @teal += teal_eval(line[/.*(?= if)/])
          end_if
        elsif !@open_ifs.empty?
          @open_ifs.last.blocks.values.last << line
        else
          @teal += teal_eval(line)
        end
      end

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

      if else_block
        @teal << else_block.map {|str| teal_eval str}
      end        
      
      @teal << "b if#{current_if.id}_end"

      current_if.blocks.values.each_with_index do |block, i|
        @teal << "if#{current_if.id}_#{i}:"
        @teal += block.map { |str| teal_eval str }
      end

      @teal << "if#{current_if.id}_end:"

    end
  end
end

class Integer
  def teal
    TEALrb::Int.new(self).teal
  end

  alias og_add +
  alias og_subtract -
  alias og_less <
  alias og_more >

  def +(other)
    from_eval = caller.join.include? TEALrb::Compiler.class_variable_get :@@eval_location
    from_pry = caller.join.include? 'pry'

    if from_eval and !from_pry
      TEALrb::Add.new self, other
    else
      og_add(other)
    end
  end
end

class NilClass
  def teal; end
end

include TEALrb

vars = {
  foo: -> { 5 + 6 },
  bar: Int.new(7) + 8,
  foobar: add(9, 10),
}

c = Compiler.new(vars)

c.compile do
  if 1+2
    3+4
  else
    5+6
  end

end

puts c.teal
