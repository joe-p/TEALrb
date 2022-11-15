# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/tealrb'
require_relative 'common'

class LocalTests < Minitest::Test
  include TestMethods

  def test_local_put
    compile_test 'local[addr("account")]["key"] = 3', ['addr account', 'byte "key"', 'int 3', 'app_local_put']
  end

  def test_app_local_get
    compile_test 'local[addr("account")]["key"]', ['addr account', 'byte "key"', 'app_local_get']
  end
end
