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

  class Compiler
    attr_reader :teal
    attr_accessor :if_count

    def initialize
      @teal = []
      @if_count = 0
    end

    def compile(vars = {}, &blk)
      seq = StringIO.new
      seq.puts '['

      ifs = [nil]
      if_level = 0

      blk.source.lines[1..-2].each do |line|
        line.strip!
        next if line.empty?

        if line[/^if /]
          if_level += 1
          ifs[if_level] = { condition: line[/(?<=if ).*/].strip, seq: StringIO.new }
          ifs[if_level][:seq].puts '['
        elsif line[/^end/]
          ifs[if_level][:seq].print ']'
          seq.puts "self.if(#{ifs[if_level][:condition]}) do\n#{ifs[if_level][:seq].string}\nend,"
          if_level -= 1
        elsif ifs[if_level]
          ifs[if_level][:seq].puts line + ','
        else
          seq.puts line + ','
        end
      end

      seq.print ']'

      @teal = eval(seq.string).map(&:teal).flatten.compact
      self
    end
    @@compile_location = "#{__FILE__}:#{__LINE__ - 3}"

    @@sequence_location = "#{__FILE__}:#{__LINE__ + 2}"
    def sequence(&blk)
      @teal += blk.call.map(&:teal).flatten.compact
    end

    def if(conditional_expression, &blk)
      IfBlock.new self, conditional_expression, blk
    end
  end

  class IfBlock < Expression
    def initialize(compiler, conditional, blk)
      @id = compiler.if_count = compiler.if_count.og_add 1

      @teal = [conditional.teal].flatten
      @teal += ["bnz if#{@id}_end"]
      @teal += blk.call.map(&:teal).flatten.compact
      @teal += ["if#{@id}_end:"]
    end

    def else(&blk)
      @else = true
      @teal.pop
      @teal = @teal.map! { |t| t == "bnz if#{@id}_end" ? "bnz if#{@id}_else" : t }
      @teal += ["b if#{@id}_end"]
      @teal += ["if#{@id}_else:"]
      @teal += blk.call.map(&:teal).flatten.compact
      @teal += ["if#{@id}_end:"]
      self
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
    from_seq = caller[-2]&.include? TEALrb::Compiler.class_variable_get :@@sequence_location
    from_compile = caller[-2]&.include? TEALrb::Compiler.class_variable_get :@@compile_location

    if (from_seq or from_compile) and !caller.join.include? 'pry'
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
approval = Compiler.new
a = approval # short name for if statements

some_expression = app_global_get('howdy') + app_global_get('efefefe')

foo = -> { 5 + 6 }
bar = Int.new(7) + 8
foobar = add(9, 10)

approval.sequence do
  [
    1,
    2,
    add,
    3 + 4,
    foo.call,
    bar,
    foobar,
    app_global_get
  ]
end

a2 = Compiler.new

a2.sequence do
  [
    a.if(1 + 2) do
      [
        3 + 4
      ]
    end.else do
      [
        5 + 6
      ]
    end,
    5 + 6
  ]
end

c = Compiler.new

vars = {
  foo: -> { 5 + 6 },
  bar: Int.new(7) + 8,
  foobar: add(9, 10),
}

c.compile(vars) do
  1 + 2
  app_global_get("some_key")
  
  if 3 + 4
      vars[:foo].call
  end
  
  vars[:bar]
  vars[:foobar]
end

puts c.teal
