# frozen_string_literal: true

require_relative '../../lib/tealrb'
class Approval < TEALrb::Contract
  @version = 5

  # The contents of main was generated by running teal2tealrb on complex.teal
  def main
    txn 'ApplicationID'
    bz :handle_createapp

    method_signature 'concat(string[2])string'
    txna 'ApplicationArgs', 0
    equal
    assert

    comment('0 and 1 byteslocation of first string')
    comment('2 and 3 byteslocation of second string')
    comment('4-5 length of first string')
    comment('6 first string')
    comment('x second string length')
    comment('x+2 secondstring')
    txna 'ApplicationArgs', 1
    store 0
    load 0
    dup
    dup
    int 0
    extract_uint16
    comment('location of first string', inline: true)
    dup
    int 2
    comment('skip the two byte length', inline: true)
    add
    store 10
    extract_uint16
    comment('length of first string', inline: true)
    store 11
    load 10
    load 11
    extract3
    store 1
    comment('store first string', inline: true)

    load 0
    dup
    dup
    int 2
    extract_uint16
    comment('location of second string', inline: true)
    dup
    int 2
    comment('skip the two byte length', inline: true)
    add
    store 12
    extract_uint16
    comment('length of second string', inline: true)
    store 13
    load 12
    load 13
    extract3
    store 2
    comment('store second string', inline: true)
    load 1
    load 2
    concat
    store 0
    byte 0x151f7c75
    comment('return bytes', inline: true)
    load 11
    comment('length of first string', inline: true)
    load 13
    comment('length of second string', inline: true)
    add
    itob
    extract 6, 2
    concat
    load 0
    comment('containing return contated strings', inline: true)
    concat
    log
    int 1
    teal_return
    :handle_createapp
    int 1
    teal_return
  end
end

c = Approval.new
c.compile
puts c.teal
