# TEALrb
TEALrb is a Ruby-based DSL for writing Algorand smart contracts. The goal is to make smart contracts easy to read and write. It's designed to support raw teal (as much as possible within the confines of Ruby syntax) while also providing some useful functionality and abstraction.

# Installation

TEALrb can be installed by adding `tealrb` to your Gemfile or running `gem install tealrb`

# Using TEALrb

To create a smart contract with TEALrb you must require the gem, create a subclass of `TEALrb::Contract`, and define an instance method `main`. `main` is a special method that will be automatically converted to TEAL upon compilation. For example:


```ruby
require 'tealrb'

class Approval < TEALrb::Contract
  def main
    1
  end
end

approval = Approval.new
approval.compile
puts approval.teal_source
```

This script will output the following:

```
#pragma version 6
    int 1
```

## Specifying TEAL Version

As seen in the above example, by default TEALrb will assume you are creating a contract for the latest TEAL version. To change this, you can change the value of the `@version` class instance variable:

```ruby
class Approval < TEALrb::Contract
  @version = 2 # => #pragma version 2

  def main
```

## Defining Subroutines

Subroutines can be defined in two ways:

```ruby
subroutine :add do |x, y|
  abi_return(x + y)
end
```

```ruby
subroutine def add(x, y)
  abi_return(x + y)
end
```

The first is more standard ruby syntax while the second will allow any Ruby IDE to know that `add` is a callable method.

## Scratch Space Management

With TEALrb you can call `load`/`store` manually or you can use the `$` prefix on variables to reserve named scratch slots. For example:

```rb
$some_key = 123
```

Will save 123 in the first available scratch slot. Assuming this is the first named slot we've reserved, this will be `slot 0`. 

```c
int 123
store 0 // some_key
```

Loading this value can be done by simply calling the variable

```rb
$some_key
```

```c
load 0 // some_key
```

To later free up this slot for a future named slot, call the `delete` method on `@sratch`:

```rb
@scratch.delete :some_key
```

This will free up `slot 0` to be used in the future, but it will only get used after the other 255 slots are used first.

## Conditionals

`if`, `else`, and `elsif` statements are supported by TEALrb. They can multi or single line.

```rb
err if $some_condition != 0

if $some_variable > 100
  log('Variable is great than 100!')
elsif $some_variable > 10
  log('Variable is greater than 10!')
else
  log('Variable is less than 10!')
end
```

## While Loops

```rb
$counter = 0
while($counter < 10) do
    $counter = $counter + 1
end
```

## App Arrays

Foreign apps, assets, and accounts can be access via the `Apps`, `Assets`, and `Accounts` classes.

### Parameters
Each of these classes also have methods that can be used for getting the respective parameters (and whether they exist or not).

```rb
$asa = Assets[0]

Global['Unit Name'] = $asa.unit_name if $asa.unit_name?
```

## Global and Local Storage

Global and local storage can be accessed via `Global` and `Local` respectively

```rb
Global["Last favorite color"] = Local[Txn.sender]['Favorite color']
```

## Grouped Transactions

Grouped transactions can be accessed via `Gtxn` or `Gtxns`. `Gtxns` must be used when the index is not static.

```rb
$payment_txn = Gtxns[Txn.group_index + 1]

assert $payment_txn.receiver == Global.current_application_address
assert $payment_txn.amount == 100_000
```

## ABI Support
TEALrb can automatically generate ABI interface JSON data and provide the logic for routing to ABI methods. To generate a proper interface, you must define the contract name, add at least one ID, and define some ABI methods. For example:

```rb
class Approval < TEALrb::Contract
  @abi_description.name = 'TEALrb_example'
  @abi_description.add_id(MAINNET, '1234')

  abi(
    args: {
      x: { type: 'uint64', desc: 'The first number' },
      y: { type: 'uint64', desc: 'The second number' }
    },
    returns: 'uint64',
    desc: 'Adds two numbers'
  )
  # define subroutine
  subroutine def add(x, y)
```

TEALrb will also add proper routing for the given methods in the compiled TEAL automatically. To disable this, set `@disable_abi_routing` to true within your `TEALrb::Contract` subclass. 


# Raw TEAL Exceptions
TEALrb supports the writing of raw TEAL with following exceptions. In these exceptions, the raw teal is not valid ruby syntax therefore the TEALrb-specific syntax must be used.

## Overview

| Description | TEAL | TEALrb |
|---|---|---|
| Opcodes that are special ruby keywords/symbols | `!` | `zero?` |
| Labels as literal symbols | `br_label:` | `:br_label` |
| Branching to labels with literal symbols | `bz br_label`| `bz :br_label` |
| Opcodes with required arguments | `gtxna 0 1 2` | `gtxna 0, 1, 2` |


## Opcodes
| TEAL | TEALrb |
|------|--------|
| `+` | `add(a, b)` |
| `-` | `subtract(a, b)` |
| `/` | `divide(a, b)` |
| `*` | `multiply(a, b)` |
| `<` | `less(a, b)` |
| `>`| `greater(a, b)` |
| `<=` | `less_eq(a, b)` |
| `>=` | `greater_eq(a, b)` |
| `&&` | `boolean_and(&&)` |
| `\|\|` | `boolean_or(a, b)` |
| `==` | `equal(a, b)` |
| `!=` | `not_equal(a, b)` |
| `!` | `zero?(expr)` |
| `%` | `modulo(a, b)` |
| `\|` | `bitwise_or(a, b)` |
| `&` | `bitwise_and(a, b)` |
| `^` | `bitwise_xor(a, b)` |
| `~` | `bitwise_invert(a, b)` |
| `b+` | `big_endian_add(a, b)` |
| `b-` | `big_endian_subtract(a, b)` |
| `b/` | `big_endian_divide(a, b)` |
| `b*` | `big_endian_multiply(a, b)` |
| `b>` | `big_endian_more(a, b)` |
| `b<=` | `big_endian_less_eq(a, b)` |
| `b>=` | `big_endian_more_eq(a, b)` |
| `b==` | `big_endian_equal(a, b)` |
| `b!=` | `big_endian_not_equal(a, b)` |
| `b%` | `big_endian_modulo(a, b)` |
| `b\|` | `padded_bitwise_or(a, b)` |
| `b&` | `padded_bitwise_and(a, b)` |
| `b^` | `padded_bitwise_xor(a, b)` |
| `b~` | `bitwise_byte_invert(a, b)` |
| `return` | `teal_return(expr)` |

### Instance Methods
Some of these opcodes can still be used on TEALrb opcodes as methods. 

| Instance Method | Opcode Method |
| --- | --- |
| `+(b)` | `add(self, b)` |
| `-(b)` | `subtract(self, b)` |
| `/(b)` | `divide(self, b)` |
| `*(b)` | `multiply(self, b)` |
| `<(b)` | `less(self, b)` |
| `>(b)`| `greater(self, b)` |
| `<=(b)` | `less_eq(self, b)` |
| `>=(b)` | `greater_eq(self, b)` |
| `&&(b)` | `boolean_and(self, b)` |
| `\|\|(b)` | `boolean_or(self, b)` |
| `==(b)` | `equal(self, b)` |
| `!=(b)` | `not_equal(self, b)` |
| `@!(b)` | `zero?(self)` |
| `%(b)` | `modulo(self, b)` |
| `\|(b)` | `bitwise_or(self, b)` |
| `&(b)` | `bitwise_and(self, b)` |
| `^(b)` | `bitwise_xor(self, b)` |
| `~(b)` | `bitwise_invert(self, b)` |

#### Example

**Valid Examples:** 
```ruby
app_global_get('Some Key') == 'Some Bytes'
```

```ruby
!app_global_get('Some Key')
```

**Invalid Examples:**
```ruby
byte 'Some Key'
app_global_get
byte 'Some Bytes'
== # => invalid ruby syntax
```

```ruby
byte 'Some Key'
app_global_get
! # => invalid ruby syntax
```

## Branching

In TEALrb, branch labels are symbol literals and when using a branching opcode the argument must be a symbol or string

| TEAL | TEALrb |
|------|--------|
| `br_label:` | `:br_label` |
| `b br_label`| `b :br_label` |
| `bz br_label`| `bz :br_label` |
| `bnz br_label`| `bnz :br_label` |

## Opcode Arguments
If an Opcode has required arguments, it must be called with the required arguments in TEALrb. To maintain valid ruby syntax, this means the arguments must be separated by commas. 

### Example
```ruby
gtxna 0 1 2 # => SyntaxError
gtxna 0, 1, 2 # => gtxna 0 1 2
```

## Comments

Comments in the Ruby source code that start with `# //` or `#//` will be included in the generated TEAL

### Example
```ruby
# this comment won't be in the TEAL
# // this comment will be in the TEAL
1 # // this comment will be in the TEAL as an inline comment
```

```c
// this comment will be in the TEAL
int 1 // this comment will be in the TEAL as an inline comment
```

## Maybe Values
TEAL has a couple of opcodes that return two values with one indicating the value actually exists and the other being the actual value (if it exists). 

TEALrb offers some additional opcodes/methods for dealing with either of these return values. The methods are listed below

| TEAL | TEALrb Exists | TEALrb Value
|------|--------|---------|
| `app_params_get` | `app_param_exists?` | `app_param_value` |
| `asset_params_get` | `asset_params_exists?` | `asset_param_value` |
| `app_local_get_ex` | `app_local_ex_exists?` | `app_local_ex_value` |
| `app_global_get_ex` | `app_global_ex_exists?` | `ex_app_global_ex_value` |


# Planned Features
- ABI type encoding/decoding
- Inner transaction abstraction
