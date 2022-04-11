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

  teal def another_teal_method
    @a = 123
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
    # Raw teal
    byte 'Key One'
    111
    app_global_put

    # Single method call
    app_global_put('Key Two', 222)

    # Two-step method call
    'Key Three'
    app_global_put 333

    teal_method
    subroutine_method(3, 4)
    ruby_method
    another_teal_method
    eval_binding_method
  end
end

approval = Approval.new
approval.compile_source
puts approval.teal