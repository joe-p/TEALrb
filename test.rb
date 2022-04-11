require_relative 'lib/teal'
require 'pry'

include TEALrb

class Approval < TEAL
  subroutine def subroutine_method(a, b)
    a+b
  end

  teal def teal_method
    @a = 1
    @b = 2
    @a+@b
  end

  def ruby_method
    @a = 5
    @b = 6
    @a+@b
  end

  def eval_binding_method
    a = 100
    b = 200

    compile_block(binding) do
      a+b
    end
  end

  def source
    teal_method
    subroutine_method(3, 4)
    ruby_method
    eval_binding_method
  end
end

approval = Approval.new
approval.compile_source
puts approval.teal