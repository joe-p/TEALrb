TEALrb is a work in progress. Expect significant commits to master which will eventually be squashed upon release.

# Raw TEAL Exceptions
TEALrb supports the writing of raw TEAL with following exceptions. In these exceptions, the raw teal is not valid ruby syntax therefore the TEALrb-specific syntax must be used.

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
| `||` | `value_or(a, b)` |
| `==` | `equal(a, b)` |
| `!=` | `not_equal(a, b)` |
| `!` | `not(expr)` |
| `%` | `modulo(a, b)` |
| `|` | `bitwise_or(a, b)` |
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
| `b|` | `padded_bitwise_or(a, b)` |
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
| `||(b)` | `value_or(self, b)` |
| `==(b)` | `equal(self, b)` |
| `!=(b)` | `not_equal(self, b)` |
| `@!(b)` | `not(self)` |
| `%(b)` | `modulo(self, b)` |
| `|(b)` | `bitwise_or(self, b)` |
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

# Opcode Coverage

| TEAL | TEALrb |
|------|--------|
| err | `err` |
| sha256 | `sha256(input)` |
| keccak256 | `keccak256(input)` |
| sha512_256 | `sha512_256(input)` |
| ed25519verify | `ed25519verify(input)` |
| ecdsa_verify v | `ecdsa_verify(index, input)` |
| ecdsa_pk_decompress v | `ecdsa_pk_decompress(index, input)` |
| ecdsa_pk_recover v | `ecdsa_pk_recover(index, input)` |
| + | `add(a, b)` |
| - | `subtract(a, b)` |
| / | `divide(a, b)` |
| * | `multiply(a, b)` |
| < | `less(a, b)` |
| > | `greater(a, b)` |
| <= | `less_eq(a, b)` |
| >= | `greater_eq(a, b)` |
| && | `value_and(&&)` |
| \|\| | `value_or(a, b)` |
| == | `equal(a, b)` |
| != | `not_equal(a, b)` |
| ! | `not(expr)` |
| len | `len(input)` |
| itob | `itob(integer)` |
| btoi | `btoi(bytes)` |
| % | `modulo(a, b)` |
| \| | `bitwise_or(a, b)` |
| & | `bitwise_and(a, b)` |
| ^ | `bitwise_xor(a, b)` |
| ~ | `bitwise_invert(a, b)` |
| mulw | `mulw(a, b)` |
| addw | `addw(a, b)` |
| divmodw | `divmodw(a, b)` |
| intcblock uint ... | `intcblock(*ints)` |
| intc i | `intc(index)` |
| intc_0 | `intc_0` |
| intc_1 | `intc_1` |
| intc_2 | `intc_2` |
| intc_3 | `intc_3` |
| bytecblock bytes ... | `bytecblock(*bytes)` |
| bytec i | `bytec(index)` |
| bytec_0 | `bytec_0` |
| bytec_1 | `bytec_1` |
| bytec_2 | `bytec_2` |
| bytec_3 | `bytec_3` |
| arg n | `arg(index)` |
| arg_0 | `arg_0` |
| arg_1 | `arg_1` |
| arg_2 | `arg_2` |
| arg_3 | `arg_3` |
| txn f | `txn(field)` |
| global f | `global(field)` |
| gtxn t f | `gtxnsas(field, transaction_index, index)` |
| load i | `load(index)` |
| store i | `store(index, value)` |
| txna f i | `txna(field, index)` |
| gtxna t f i | `gtxna(transaction_index, field, index)` |
| gtxns f | `gtxns(field, transaction_index)` |
| gtxnsa f i | `gtxnsa(field, index, transaction_index)` |
| gload t i | `gload(transaction_index, index)` |
| gloads i | `gloads(index, transaction_index)` |
| gaid t | `gaid(transaction_index)` |
| gaids | `gaids(transaction)` |
| loads | `loads(index)` |
| stores | `stores(index, value)` |
| bnz target | `bnz(target)` |
| bz target | `bz(target)` |
| b target | `b(target)` |
| return | `return(expr)` |
| assert | `assert(expr)` |
| pop | `pop(expr)` |
| dup | `dup(expr)` |
| dup2 | `dup2(expr_a, expr_b)` |
| dig n | `dig(index)` |
| swap | `swap(expr_a, expr_b)` |
| select | `select(expr_a, expr_b, expr_c)` |
| cover n | `cover(count)` |
| uncover n | `uncover(count)` |
| concat | `concat(a, b)` |
| substring s e | `substring(start, exclusive_end, byte_array)` |
| substring3 | `substring3(byte_array, start, exclusive_end)` |
| getbit | `getbit(input, bit_index)` |
| setbit | `setbit(input, bit_index, value)` |
| getbyte | `getbyte(input, byte_index)` |
| setbyte | `setbyte(byte_array, byte_index, value)` |
| extract s l | `extract(start, length, byte_array)` |
| extract3 | `extract3(byte_array, start, exclusive_end)` |
| extract_uint16 | `extract_uint16(byte_array, start)` |
| extract_uint32 | `extract_uint32(byte_array, start)` |
| extract_uint64 | `extract_uint64(byte_array, start)` |
| balance | `balance(account)` |
| app_opted_in | `app_opted_in(account, app)` |
| app_local_get | `app_local_get(account, key)` |
| app_local_get_ex | `app_local_get_ex(account, application, key)` |
| app_global_get | `app_global_get(key)` |
| app_global_get_ex | `app_global_get_ex(app, key)` |
| app_local_put | `app_local_put(account, key, value)` |
| app_global_put | `app_global_put(key, value)` |
| app_local_del | `app_local_del(account, key)` |
| app_global_del | `app_global_del(key)` |
| asset_holding_get f | `asset_holding_get(field, account, asset)` |
| asset_params_get f | `asset_params_get(field, asset)` |
| app_params_get f | `app_params_get(field, asset)` |
| acct_params_get f | `acct_params_get(field, account)` |
| min_balance | `min_balance(account)` |
| pushbytes bytes | `pushbytes(string)` |
| pushint uint | `pushint(integer)` |
| callsub target | `callsub(name, *args)` |
| retsub | `retsub` |
| shl | `shl(a, b)` |
| shr | `shr(a, b)` |
| sqrt | `sqrt(integer)` |
| bitlen | `bitlen(input)` |
| exp | `exp(a, b)` |
| expw | `expw(a, b)` |
| bsqrt | `bsqrt(big_endian_uint)` |
| divw | `divw(a, b)` |
| b+ | `big_endian_add(a, b)` |
| b- | `big_endian_subtract(a, b)` |
| b/ | `big_endian_divide(a, b)` |
| b* | `big_endian_multiply(a, b)` |
| b> | `big_endian_more(a, b)` |
| b<= | `big_endian_less_eq(a, b)` |
| b>= | `big_endian_more_eq(a, b)` |
| b== | `big_endian_equal(a, b)` |
| b!= | `big_endian_not_equal(a, b)` |
| b% | `big_endian_modulo(a, b)` |
| b\| | `padded_bitwise_or(a, b)` |
| b& | `padded_bitwise_and(a, b)` |
| b^ | `padded_bitwise_xor(a, b)` |
| b~ | `bitwise_byte_invert(a, b)` |
| bzero | `bzero(length)` |
| log | `log(byte_array)` |
| itxn_begin | `itxn_begin` |
| itxn_field f | `itxn_field(field, value)` |
| itxn_submit | `itxn_submit` |
| itxn f | `txn(field)` |
| itxna f i | `itxna(field, index)` |
| itxn_next | `itxn_next` |
| gitxn t f | `gitxn(transaction_index, field)` |
| gitxna t f i | ` gitxna(transaction_index, field, index)` |
| txnas f | `txnas(field, index)` |
| gtxnas t f | `gtxn(index, field)` |
| gtxnsas f | `gtxnsas(field, index, transaction_index)` |
| args | `args(index)` |
| gloadss | `gloadss(transaction, index)` |
| itxnas f | `itxnas(field, index)` |
| gitxnas t f | `gitxnas(transaction_index, field, index)` |

# Features
- [x] Subroutine definition
- [x] if/elsif/else branching
- [x] ABI JSON generation
- [ ] Looping
- [ ] ABI type encoding/decoding
- [ ] Scratch space management
