require_relative 'lib/teal'
require 'pry'

include TEALrb

approval = Compiler.new

approval.subroutine('increment_global') do |global_key, amount|
  app_global_put(global_key, app_global_get(global_key) + amount)
end

approval.main do
  app_global_put('test', 0)
  increment_global('test', 1)
  increment_global('test', 1)
  increment_global('test', 1)
end

puts approval.teal