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

    # //0 and 1 byteslocation of first string
    # //2 and 3 byteslocation of second string
    # //4-5 length of first string
    # //6 first string
    # //x second string length
    # //x+2 secondstring
    txna 'ApplicationArgs', 1
    store 0
    load 0
    dup
    dup
    int 0
    extract_uint16 # //location of first string
    dup
    int 2 # //skip the two byte length
    add
    store 10
    extract_uint16 # //length of first string
    store 11
    load 10
    load 11
    extract3
    store 1 # //store first string

    load 0
    dup
    dup
    int 2
    extract_uint16 # //location of second string
    dup
    int 2 # //skip the two byte length
    add
    store 12
    extract_uint16 # //length of second string
    store 13
    load 12
    load 13
    extract3
    store 2 # //store second string
    load 1
    load 2
    concat
    store 0
    byte 0x151f7c75 # //return bytes
    load 11 # //length of first string
    load 13 # //length of second string
    add
    itob
    extract 6, 2
    concat
    load 0 # //containing return contated strings
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
File.write('complex_tealrb.teal', c.teal.join("\n"))
