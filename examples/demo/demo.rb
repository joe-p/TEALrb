# frozen_string_literal: true

require_relative '../../lib/tealrb'

class Approval < TEALrb::Contract
  @abi_description.name = 'TEALrb_Demo'
  @abi_description.add_id(MAINNET, '1234')
  @debug = true

  # Specify ABI arg types, return type, and desc
  abi(
    args: {
      x: { type: 'uint64', desc: 'The first number' },
      y: { type: 'uint64', desc: 'The second number' }
    },
    returns: 'uint64',
    desc: 'Adds two numbers, subtracts two numbers, then multiplies two numbers'
  )
  # define subroutine
  subroutine def subroutine_method(x, y)
    x + y
    x - y
    abi_return(itob(x * y))
  end

  # Evaluate all code in the method as TEALrb expressions
  teal def teal_method
    x = 3
    y = 4
    x + y # => ['int 3', 'int 4', '+']
  end

  # Another way to define teal methods
  teal :another_teal_method do |a, b|
    a / b
  end

  # Yet another way to define teal methods
  @teal_methods[:yet_another_teal_method] = ->(arg1, arg2) { arg1 % arg2 }

  # Only evalulates the return value as a TEALrb expression
  def ruby_method
    x = 5
    y = 6
    x + y # => 11
  end

  def main
    # Comments start with // will show in TEAL. For example:
    # // This comment will show in TEAL
    # This comment will not show in TEAL

    # // raw teal
    byte 'Key One' # // this will be an in-line comment
    int 111
    app_global_put

    int 100
    int 200
    add # can't use some ruby operators (+ => add, - => subtract, * => multiply, etc.)

    # // single method call
    app_global_put('Key Two', 222)

    # // two step method call
    'Key Three' # // string literals are implicitly bytes
    app_global_put 333

    # // Global put/get as hash
    Global['Key Four'] = 444
    Global['Key Five']

    # // Local put/get as hash
    Local[Txn.sender]['Local Key'] = 'Some Value'
    Local[Txn.receiver]['Local Key']

    # Variable assignment is a statement that doesn't evaluate to a TEALrb expression
    # // using variables
    @key_four = 'Key Four'         # => nil
    @key_four                      # => 'byte "Key Four"'
    key_four_value = 444           # => nil
    app_global_put(key_four_value) # => ['int 444', 'app_global_put']

    # // combining raw teal with conditionals
    byte 'Bad Key'
    if app_global_get
      err
    end

    # // more complex conditionals
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

    # See header comments of each method for details
    # // calling methods
    # // subroutine method
    subroutine_method(1, 2)
    # // teal method
    teal_method
    # // ruby method
    int(ruby_method)
    # // another_teal_method
    another_teal_method(1111, 2222)
    # // yet_another_teal_method
    yet_another_teal_method(3333, 4444)

    # All of the following are the same
    # // accessing specific indexes/fields
    gtxn(0, 'Sender') # // gtxn(0, 'Sender')
    Gtxn.sender(0) # // Gtxn.sender(0)
    Gtxn[0].sender # // Gtxn[0].sender
    gtxn_var = Gtxn[0]
    gtxn_var.sender # // gtxn_var.sender

    # // manual branching
    b :manual_br
    app_global_get('Unreachable')
    :manual_br # Branch labels are prefiexed with ":" (literal symbol)
    app_global_get('Manual Br')

    # // placeholders
    app_global_put('Some Key', placeholder('REPLACE_ME'))
    gtxn(1, 'ANOTHER_THING_TO_REPLACE')

    # // TxnType enums
    TxnType.pay

    # // store/load to named scratch slots
    @scratch['some key'] = 123
    @scratch['some key']
    @scratch['another key'] = 321
    @scratch['another key']

    @scratch.delete 'some_key'
    @scratch.delete 'another key'

    puts rb('HERE') # 'HERE' not transpiled to TEAL

    # // while loops
    while Global['counter'] < 3
      Global['counter'] = Global['counter'] + 1
    end

    push_encoded(true, :bool)
    push_encoded(24, :uint32)
    push_encoded(1.23, :ufixed16x2)
    push_encoded([1.23, 1.56], :fixed_array, :ufixed16x2)
  end
end

approval = Approval.new
approval.compile
puts approval.teal
File.write('demo.teal', approval.teal.join("\n"))
File.write('demo.json', JSON.pretty_generate(approval.abi_hash))
