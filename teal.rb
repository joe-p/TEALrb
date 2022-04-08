require 'pry'
require 'method_source'
require_relative 'expressions'

class String
  def teal
    TEALrb::Bytes.new(self).teal
  end
end

module TEALrb
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

approval = Compiler.new

approval.defsub('increment_global') do |global_key, amount|
  app_global_put(global_key, app_global_get(global_key) + amount)
end

approval.vars.foo = -> { 1 + 2 }
approval.vars.bar = add(3, 4)

approval.compile do
  if vars.foo.call
    vars.bar
  elsif 5 + 6
    7
    8
    add
  else
    add 9, 10
  end

  13 + 14 if app_global_get 'some_key'
end

puts approval.teal
