# frozen_string_literal: true

require_relative '../../lib/tealrb'

class DemoContract < TEALrb::Contract
  @abi_interface.name = 'AnotherName'
  @abi_interface.add_id(MAINNET, '1234')

  # @subroutine
  # @param asa [asset]
  # @param axfer_txn [axfer]
  def helper_subroutine(asa, axfer_txn)
    assert axfer_txn.sender == asa.creator
  end

  # @teal
  def helper_teal_method(asa, axfer_txn)
    assert axfer_txn.sender == asa.creator
  end

  # @abi
  # This is an abi method that does some stuff
  # @param asa [asset] Some asset
  # @param axfer_txn [axfer] A axfer txn
  # @param another_app [application] Another app
  # @param some_number [uint64]
  # @return [uint64]
  def some_abi_method(asa, axfer_txn, another_app, some_number)
    assert asa.unit_name?
    assert axfer_txn.sender == Txn.sender
    assert another_app.extra_program_pages?

    helper_subroutine(asa, axfer_txn) # // calling helper_subroutine calls a subroutine
    # // calling helper_teal_method writes TEAL in-place
    helper_teal_method(asa, axfer_txn)

    return itob some_number + 1
  end

  # @subroutine
  # @param n [uint64] Some number
  # @param m [bytes] Some bytes
  def some_subroutine(n, m)
    log(m)
    n + 1
  end

  # @teal
  # Evaluate all code in the method as TEALrb expressions
  def teal_method
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
    @key_four = 'Key Four' # => nil
    @key_four # => 'byte "Key Four"'
    key_four_value = 444 # => nil
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
    # // subroutine
    some_subroutine(1, 'one')
    # // teal method
    teal_method
    # // ruby method
    int(ruby_method)

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

    rb('HERE') # 'HERE' not transpiled to TEAL

    # // while loops
    while Global['counter'] < 3
      Global['counter'] = Global['counter'] + 1
    end

    # // opcodes with "maybe" values

    # // using app_global_ex_exists? and app_global_ex_value
    if app_global_ex_exists?(1337, 'some_key')
      app_global_ex_value(1337, 'some_key')
    else
      log 'some_key does not exist'
    end

    # // using app_global_get_ex and store/load
    app_local_get_ex(1337, 'some_key')
    store 0
    store 1

    exists = load 0
    value = load 1

    if exists
      value
    else
      log 'some_key does not exist'
    end

    # // inline if statement
    b :label if btoi > 10

    # // Accessing arrays
    # // Assets[0].creator
    Assets[0].creator
    # // Accounts[1].balance?
    Accounts[1].balance?
    # // Apps[1 + 1].creator
    Apps[1 + 1].creator

    # // sratch var shorthand with $
    $another_scatch_var = 123
    $another_scatch_var

    box_create 'some box', 40
    Box['some box']
    Box['some box'] = 'some other value'
  end
end

approval = DemoContract.new
File.write("#{__dir__}/demo.teal", approval.formatted_teal)
File.write("#{__dir__}/demo.json", JSON.pretty_generate(approval.abi_hash))
