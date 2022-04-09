require_relative 'lib/teal'
include TEALrb

approval = Compiler.new

approval.defsub('increment_global') do |global_key, amount|
  app_global_put(global_key, app_global_get(global_key) + amount)
end

approval.vars.foo = -> { 1 + 2 }
approval.vars.bar = add(3, 4)

approval.compile do
  if vars.foo.call
    vars.bar
  elsif 5 + 6
    7
    8
    add
  else
    add 9, 10
  end

  13 + 14 if app_global_get 'some_key'
  5 / 1
end

puts approval.teal