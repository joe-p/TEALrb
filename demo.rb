require_relative 'lib/teal'
require 'pry'

include TEALrb

class Approval < TEAL
  subroutine def subroutine_method(a, b)
    a+b
  end

  teal def teal_method
    @a = 3
    @b = 4
    @a+@b
  end

  def ruby_method
    @a = 5
    @b = 6
    @a+@b
  end

  def eval_binding_method
    a = 7
    b = 8

    compile_block(binding) do
      a+b
    end
  end

  teal def another_teal_method
    @a = 9
    @a+@b
  end

  def source
    # Raw teal
    byte 'Key One'
    int 111
    app_global_put

    # Single method call
    app_global_put('Key Two', 222)

    # Two-step method call
    'Key Three'
    app_global_put 333

    subroutine_method(1, 2)
    teal_method
    ruby_method
    eval_binding_method
    another_teal_method
  end
end

approval = Approval.new
approval.compile_source
puts approval.teal