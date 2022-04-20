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

### Example
These opcodes can still be used on TEALrb expressions:

```ruby
app_global_get('Some Key') == 'Some Bytes'
```

They just can't be used on a single line by themselves:

```ruby
byte 'Some Key'
app_global_get
byte 'Some Bytes'
== # => invalid ruby syntax
```

## Branch Labels
| TEAL | TEALrb |
|------|--------|
| `br_label:` | `:br_label` |

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
| intcblock uint ... | TODO |
| intc i | TODO |
| intc_0 | `intc_0` |
| intc_1 | `intc_1` |
| intc_2 | `intc_2` |
| intc_3 | `intc_3` |
| bytecblock bytes ... | TODO |
| bytec i | TODO |
| bytec_0 | `bytec_0` |
| bytec_1 | `bytec_1` |
| bytec_2 | `bytec_2` |
| bytec_3 | `bytec_3` |
| arg n | TODO |
| arg_0 | `arg_0` |
| arg_1 | `arg_1` |
| arg_2 | `arg_2` |
| arg_3 | `arg_3` |
| txn f | `txn(field)` |
| global f | `global(field)` |
| gtxn t f | TODO |
| load i | `load(index)` |
| store i | `store(index, value)` |
| txna f i | `txna(field, index)` |
| gtxna t f i | TODO |
| gtxns f | TODO |
| gtxnsa f i | TODO |
| gload t i | TODO |
| gloads i | TODO |
| gaid t | TODO |
| gaids | `gaids(transaction)` |
| loads | `loads(index)` |
| stores | `stores(index, value)` |
| bnz target | TODO |
| bz target | TODO |
| b target | TODO |
| return | TODO |
| assert | `assert(expr)` |
| pop | `pop(expr)` |
| dup | `dup(expr)` |
| dup2 | `dup2(expr_a, expr_b)` |
| dig n | TODO |
| swap | `swap(expr_a, expr_b)` |
| select | `select(expr_a, expr_b, expr_c)` |
| cover n | TODO |
| uncover n | TODO |
| concat | `concat(a, b)` |
| substring s e | TODO |
| substring3 | `substring3(byte_array, start, exclusive_end)` |
| getbit | `getbit(input, bit_index)` |
| setbit | `setbit(input, bit_index, value)` |
| getbyte | `getbyte(input, byte_index)` |
| setbyte | `setbyte(byte_array, byte_index, value)` |
| extract s l | TODO |
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
| asset_holding_get f | TODO |
| asset_params_get f | TODO |
| app_params_get f | TODO |
| acct_params_get f | TODO |
| min_balance | `min_balance(account)` |
| pushbytes bytes | TODO |
| pushint uint | TODO |
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
| itxna f i | TODO |
| itxn_next | `itxn_next` |
| gitxn t f | TODO |
| gitxna t f i | TODO |
| txnas f | TODO |
| gtxnas t f | `gtxn(index, field)` |
| gtxnsas f | TODO |
| args | `args(index)` |
| gloadss | `gloadss(transaction, index)` |
| itxnas f | TODO |
| gitxnas t f | TODO |

# Features
- [x] Subroutine definition
- [x] if/elsif/else branching
- [x] ABI JSON generation
- [ ] ABI type encoding/decoding
- [ ] Scratch space management
- [ ] Looping

# Milestones
- [ ] 100% opcode coverage
- [ ] 100% enum coverage
- [ ] PyTEAL feature parity
