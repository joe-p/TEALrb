# TEALrb
TEALrb is a Ruby-based DSL for writing Algorand smart contracts. The goal is to create a way to easily write contracts without adding too much unavoidable abstraction on top of raw TEAL. It's designed to support raw teal (as much as possible within the confines of Ruby syntax) while also providing some useful functionality such as conditionals, variables, methods, and ABI support. 

## Why Not PyTeal?

PyTeal is a great language for writing smart contracts, but I found it to be a bit too opinionated for my personal taste. The goal of TEALrb is to create a way to write smart contracts with the efficiency of TEAL while also offering the QOL benefits of a higher-level language. 

### Comparison
#### PyTeal
```python
    on_closeout = Seq(
        [
            get_vote_of_sender,
            If(
                And(
                    Global.round() <= App.globalGet(Bytes("VoteEnd")),
                    get_vote_of_sender.hasValue(),
                ),
                App.globalPut(
                    get_vote_of_sender.value(),
                    App.globalGet(get_vote_of_sender.value()) - Int(1),
                ),
            ),
            Return(Int(1)),
        ]
    )
```
#### TEALrb
```ruby
  teal def on_closeout
    get_vote_of_sender

    if Global.round <= Global['VoteEnd'] && vote_of_sender_has_value?
      Global[vote_of_sender_value] = Global[vote_of_sender_value] - 1
    end

    teal_return 1
  end
```
# Using TEALrb

To create a smart contract with TEALrb you must require the gem, create a subclass of `TEALrb::Contract`, and define an instance method `main`. `main` is a special method that will be automatically converted to TEAL upon compilation. For example:


```ruby
require_relative 'lib/tealrb'

class Approval < TEALrb::Contract
  def main
    1
  end
end

approval = Approval.new
approval.compile
puts approval.teal
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

There are two primary ways of defining a subroutine 

### subroutine block

The `subroutine` method takes a symbol and a block. The symbol is used for the name of the subroutine while the block is transpiled for the logic of the subroutine. 

```ruby
subroutine :subroutine_method do |x, y|
  x + y
end
```

### subroutine def
The problem with the above syntax is that language servers (such as solargraph) will not recognize `subroutine_method` as a callable method. This means IDEs will not provide intellisense for subroutine calls. To solve this, it's useful to define an actual ruby method that is transpiled to the subroutine definition.

Calling the `subroutine` method with just a symbol as an argument will tell TEALrb to transpile the instance method with the given name as a subroutine. For example:

```ruby
def subroutine_method(x, y)
  x + y
end
subroutine :subroutine_method # => transpiles subroutine_method as a callable subroutine in the generated TEAL
```

Since the `def` keyword returns a symbol, you can directly pass the method definition as an argument to subroutine: 

```ruby
subroutine def subroutine_method(x, y)
  x + y
end
```

# How TEALrb Works

At a high-level, TEALrb transpile Ruby into TEAL. For example, a string literal `'hello'` becomes `byte "hello"`. In reality, there are actually two stags of transpilation. First, the given Ruby is rewritten to use TEALrb methods and then that TEALrb mehotd is called, which is what actually generates the TEAL.

For example, `'hello'` becomes `byte('hello')` which adds `byte "hello"` to the generated TEAL. The re-writing step is used for things such as string literals, integer literals, symbol literals (which become branch labels), and keywords such as `if` and `&&`.

## Example

If you create a contract with class instance variable `@debug = true` you will see this the steps of this process. For example:

```ruby
require_relative 'lib/tealrb'

class Approval < TEALrb::Contract
    @debug = true

  subroutine def example_subroutine(x, y)
    if x > y
      'x is bigger'
    else
      'x is smaller'
    end
  end

  def main
    example_subroutine(1, 2)
  end
end

approval = Approval.new
approval.compile
```

```
DEBUG: Rewriting the following code:
  subroutine def example_subroutine(x, y)
    if x > y
      'x is bigger'
    else
      'x is smaller'
    end
  end

DEBUG: Resulting TEALrb code:
   IfBlock.new(@teal,  (x.call > y.call) ) do
      byte('x is bigger')
    end.else do
      byte('x is smaller')
    end

DEBUG: Evaluating the following code (subroutine: example_subroutine):
store 200
comment('y', inline: true)
y = -> { load 200; comment('y', inline: true) }
store 201
comment('x', inline: true)
x = -> { load 201; comment('x', inline: true) }
   IfBlock.new(@teal,  (x.call > y.call) ) do
      byte('x is bigger')
    end.else do
      byte('x is smaller')
    end
retsub

DEBUG: Resulting TEAL (subroutine: example_subroutine):
store 200 // y
store 201 // x
load 201 // x
load 200 // y
>
bz if0_else0
byte "x is bigger"
b if0_end
if0_else0:
byte "x is smaller"
if0_end:
retsub

DEBUG: Rewriting the following code:
  def main
    example_subroutine(1, 2)
  end

DEBUG: Resulting TEALrb code:
  example_subroutine(int(1), int(2))

DEBUG: Evaluating the following code (main):
  example_subroutine(int(1), int(2))

DEBUG: Resulting TEAL (main):
int 1
int 2
callsub example_subroutine
```


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


# Planned Features

- Looping
- ABI type encoding/decoding
- Scratch space management
