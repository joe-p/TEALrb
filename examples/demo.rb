require_relative '../lib/teal'

class Approval < TEALrb::Contract
  @@abi.name = 'TEALrb_Demo'
  @@abi.add_id(Networks.mainnet, '1234')

  # Specify ABI arg types, return type, and desc
  abi(
    args: [uint64, uint64],
    returns: uint64,
    desc: 'Adds two numbers, subtracts two numbers, then multiplies two numbers'
  )
  # define subroutine
  subroutine def subroutine_method(a, b)
    a + b
    a - b
    abi_return(itob(a * b))
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
    a + b # => ['int 11']
  end

  # Only evalutes the code in the compile_block block as TEALrb expressions
  def explicit_compile_method(a)
    # Since this if statement is outside of the compile block, it is not evaluated as TEALrb expressions
    b = if 100 < 1_000
          8
        else
          88_888
        end

    # The binding is passed here so the evaluation of the compile block includes local variables
    compile_block(binding) do
      a + b # => ['int 7', 'int 8', '+']
    end
  end

  def main
    # Raw teal
    byte 'Key One'
    int 111
    app_global_put

    int 100
    int 200
    add # can't use some ruby operators (+ => add, - => subtract, * => multiply, etc.)

    # Single method call
    app_global_put('Key Two', 222)

    # Two-step method call
    'Key Three' # string literals are implicitly bytes
    app_global_put 333

    # Using variables
    # Variable assignment is a statement that doesn't evaluate to a TEALrb expression
    @key_four = 'Key Four'         # => nil
    @key_four                      # => 'byte "Key Four"'
    key_four_value = 444           # => nil
    app_global_put(key_four_value) # => ['int 444', 'app_global_put']

    # combining raw teal with conditionals
    byte 'Bad Key'
    err if app_global_get

    # More complex conditionals
    if app_global_get('First Word') == 'Hi'
      app_global_put('Second Word', 'Mom')
    elsif app_global_get('First Word') == 'Hello'
      byte 'Second Word'
      byte 'World'
      app_global_put
    elsif app_global_get('First Word') == 'Howdy'
      app_global_put('Second Word', 'Partner')
    else
      app_global_put('Second Word', '???')
    end

    subroutine_method(1, 2)
    teal_method
    ruby_method
    explicit_compile_method(7)
  end
end

approval = Approval.new
approval.compile_main
IO.write('demo.teal', approval.teal)
IO.write('demo.json', JSON.pretty_generate(approval.abi_hash))
