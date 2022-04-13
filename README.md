TEALrb is a work in progress. Expect significant commits to master which will eventually be squashed upon release.

# Opcode Coverage

| TEAL | TEALrb |
|------|--------|
| err | `err` |
| sha256 | `sha256(input)` |
| keccak256 | TODO |
| sha512_256 | TODO |
| ed25519verify | TODO |
| ecdsa_verify v | TODO |
| ecdsa_pk_decompress v | TODO |
| ecdsa_pk_recover v | TODO |
| + | `add(a, b)` |
| - | `subtract(a, b)` |
| / | `divide(a, b)` |
| * | `multiply(a, b)` |
| < | `less(a, b)` |
| > | `greater(a, b)` |
| <= | `less_eq(a, b)` |
| >= | `greater_eq(a, b)` |
| && | TODO |
| \|\| | TODO |
| == | `equal(a, b)` |
| != | `no_equal(a, b)` |
| ! | `not(expr)` |
| len | TODO |
| itob | TODO |
| btoi | `btoi(bytes)` |
| % | TODO |
| \| | TODO |
| & | `bitwise_and` |
| ^ | TODO |
| ~ | TODO |
| mulw | TODO |
| addw | TODO |
| divmodw | TODO |
| intcblock uint ... | TODO |
| intc i | TODO |
| intc_0 | TODO |
| intc_1 | TODO |
| intc_2 | TODO |
| intc_3 | TODO |
| bytecblock bytes ... | TODO |
| bytec i | TODO |
| bytec_0 | TODO |
| bytec_1 | TODO |
| bytec_2 | TODO |
| bytec_3 | TODO |
| arg n | TODO |
| arg_0 | TODO |
| arg_1 | TODO |
| arg_2 | TODO |
| arg_3 | TODO |
| txn f | TODO |
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
| gaids | TODO |
| loads | TODO |
| stores | TODO |
| bnz target | TODO |
| bz target | TODO |
| b target | TODO |
| return | TODO |
| assert | TODO |
| pop | TODO |
| dup | TODO |
| dup2 | TODO |
| dig n | TODO |
| swap | TODO |
| select | TODO |
| cover n | TODO |
| uncover n | TODO |
| concat | TODO |
| substring s e | TODO |
| substring3 | TODO |
| getbit | TODO |
| setbit | TODO |
| getbyte | TODO |
| setbyte | TODO |
| extract s l | TODO |
| extract3 | TODO |
| extract_uint16 | TODO |
| extract_uint32 | TODO |
| extract_uint64 | TODO |
| balance | TODO |
| app_opted_in | `app_opted_in(account, app)` |
| app_local_get | `app_local_get(account, key)` |
| app_local_get_ex | TODO |
| app_global_get | `app_global_get(key)` |
| app_global_get_ex | TODO |
| app_local_put | TODO |
| app_global_put | `app_global_put(key, value)` |
| app_local_del | TODO |
| app_global_del | TODO |
| asset_holding_get f | TODO |
| asset_params_get f | TODO |
| app_params_get f | TODO |
| acct_params_get f | TODO |
| min_balance | TODO |
| pushbytes bytes | TODO |
| pushint uint | TODO |
| callsub target | `callsub(name, *args)` |
| retsub | TODO |
| shl | TODO |
| shr | TODO |
| sqrt | TODO |
| bitlen | TODO |
| exp | TODO |
| expw | TODO |
| bsqrt | TODO |
| divw | TODO |
| b+ | TODO |
| b- | TODO |
| b/ | TODO |
| b* | TODO |
| b< | TODO |
| b> | TODO |
| b<= | TODO |
| b>= | TODO |
| b== | TODO |
| b!= | TODO |
| b% | TODO |
| b\| | TODO |
| b& | TODO |
| b^ | TODO |
| b~ | TODO |
| bzero | TODO |
| log | TODO |
| itxn_begin | `itxn_begin` |
| itxn_field f | `itxn_field(field, value)` |
| itxn_submit | `itxn_submit` |
| itxn f | `txn(field)` |
| itxna f i | TODO |
| itxn_next | TODO |
| gitxn t f | TODO |
| gitxna t f i | TODO |
| txnas f | TODO |
| gtxnas t f | `gtxn(index, field)` |
| gtxnsas f | TODO |
| args | TODO |
| gloadss | TODO |
| itxnas f | TODO |
| gitxnas t f | TODO |