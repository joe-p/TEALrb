# frozen_string_literal: true

require_relative '../../lib/tealrb'

class Approval < TEALrb::Contract
  abi_description.name = 'TEALrb_Demo'
  abi_description.add_id(MAINNET, '1234')

  # Specify ABI arg types, return type, and desc
  abi(
    args: {
      x: { type: Uint64, desc: 'The first number' },
      y: { type: Uint64, desc: 'The second number' }
    },
    returns: Uint64,
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

  # Only evalulates the return value as a TEALrb expression
  def ruby_method
    x = 5
    y = 6
    x + y # => 11
  end

  def main
    comment 'raw teal'
    byte 'Key One'
    int 111
    app_global_put

    int 100
    int 200
    add # can't use some ruby operators (+ => add, - => subtract, * => multiply, etc.)

    comment 'single method call'
    app_global_put('Key Two', 222)

    comment 'two step method call'
    'Key Three' # string literals are implicitly bytes
    app_global_put 333

    # Variable assignment is a statement that doesn't evaluate to a TEALrb expression
    comment 'using variables'
    @key_four = 'Key Four'         # => nil
    @key_four                      # => 'byte "Key Four"'
    key_four_value = 444           # => nil
    app_global_put(key_four_value) # => ['int 444', 'app_global_put']

    comment 'combining raw teal with conditionals'
    byte 'Bad Key'
    if app_global_get
      err
    end

    comment 'more complex conditionals'
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
    comment 'calling methods'
    comment 'subroutine method'
    subroutine_method(1, 2)
    comment 'teal method'
    teal_method
    comment 'ruby method'
    int(ruby_method)

    # All of the following are the same
    comment 'accessing specific indexes/fields'
    gtxn(0, 'Sender')
    Gtxn.sender(0)
    Gtxn[0].sender

    comment 'manual branching'
    b :manual_br
    app_global_get('Unreachable')
    :manual_br # Branch labels are prefiexed with ":" (literal symbol)
    app_global_get('Manual Br')

    comment 'placeholders'
    app_global_put('Some Key', placeholder('REPLACE_ME'))
    gtxn(1, 'ANOTHER_THING_TO_REPLACE')

    comment 'Global put/get as hash'
    Global['Key Four'] = 444
    Global['Key Five']

    comment 'Local put/get as hash'
    Local[Txn.sender]['Local Key'] = 'Some Value'
    Local[Txn.receiver]['Local Key']

    comment 'TxnType enums'
    TxnType.pay
  end
end

approval = Approval.new
approval.compile
puts approval.teal
File.write('demo.teal', approval.teal.join("\n"))
File.write('demo.json', JSON.pretty_generate(approval.abi_hash))
