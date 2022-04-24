# TEALrb
TEALrb is a Ruby-based DSL for writing Algorand smart contracts. The goal is to create a way to easily write contracts without adding too much unavoidable abstraction on top of raw TEAL. It's designed to support raw teal (as much as possible within the confines of Ruby syntax) while also providing some useful functionality such as conditionals, variables, methods, and ABI support. 

## Why Not pyTEAL?

pyTEAL is a great language for writing smart contracts, but I found it to be a bit too opinionated for my personal taste. The goal of TEALrb is to create a way to write smart contracts with the efficiency of TEAL while also offer the QOL benefits of a higher-level language. 

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
| `&&` | `value_and(&&)` |
| `\|\|` | `value_or(a, b)` |
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
| `&&(b)` | `value_and(self, b)` |
| `\|\|(b)` | `value_or(self, b)` |
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

# Planned Features

- Looping
- ABI type encoding/decoding
- Scratch space management
