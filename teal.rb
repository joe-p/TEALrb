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

  class AppGlobalPut < Expression
    def initialize(key, value)
      @teal = [value.teal, key.teal, 'app_global_put']
    end
  end

  def app_global_put(key = nil, value = nil)
    AppGlobalPut.new(key, value)
  end

  class Store < Expression
    def initialize(index, value)
      @teal = [value.teal, "store #{index}"]
    end
  end

  def store(index, value = nil)
    Store.new(index, value)
  end

  class Load < Expression
    def initialize(index)
      @teal = ["load #{index}"]
    end
  end

  def load(index = nil)
    Load.new(index)
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
      eval("(#{str}).teal")
    end

    def defsub(name, &blk)
      params = blk.parameters.map(&:last).map(&:to_s)
      @teal << name + ':'
      str = blk.source.lines[1..-2].join("\n")
      
      params.each_with_index do |name, i|
        @teal << "store #{201+i}"
        str.gsub!(name, "load(#{201+i})")
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
        @teal << "b if#{current_if.id}_end"
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

c = Compiler.new

c.vars.foo = -> { 75 + 76 }
c.vars.bar = Int.new(77) + 78
c.vars.foobar = add(79, 710)

c.defsub('increment_global') do |global_key, amount|
  app_global_put(global_key, app_global_get(global_key) + amount)
end

c.compile do
  if 1+2
    3+4
  elsif 5+6
    7+8
  else
    9+10
  end
  vars.foo.call
end

puts c.teal
