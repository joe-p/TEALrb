require_relative 'lib/teal'
require 'pry'

include TEALrb

class Approval < TEAL
  # Defines a subroutine in the TEAL code
  subroutine def subroutine_method(a, b)
    a+b
  end

  # Evaluate all code in the method as TEALrb expressions
  teal def teal_method
    a = 3
    b = 4
    a + b # => ['int 3', 'int 4', '+'] 
  end

  # Only evalulates the return value as a TEALrb expression
  def ruby_method
    a = 5
    b = 6
    a+b # => ['int 11']
  end

  # Only evalutes the code in the compile_block block as TEALrb expressions
  def explicit_compile_method
    # Since this if statement is outside of the compile block, it is not evaluated as TEALrb expressions
    if 100 < 1_000
      a = 7
    else
      a = 777777
    end

    # The binding is passed here so the evaluation of the compile block includes local variables
    compile_block(binding) do
      b = 8
      a+b # => ['int 7', 'int 8', '+'] 
    end
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

    # Using variables
    # Variable assignment is a statement that doesn't evaluate to a TEALrb expression
    @key_four = 'Key Four'         # => nil
    @key_four                      # => 'byte "Key Four"'
    key_four_value = 444           # => nil
    app_global_put(key_four_value) # => ['int 444', 'app_global_put']

    subroutine_method(1, 2)
    teal_method
    ruby_method
    explicit_compile_method
  end
end

approval = Approval.new
approval.compile_source
puts approval.teal