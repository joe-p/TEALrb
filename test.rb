require_relative 'lib/teal'
require 'pry'

include TEALrb

class Approval < TEAL
  subroutine def increment_global(global_key, amount)
    app_global_put(global_key, app_global_get(global_key) + amount)
  end

  def source
    app_global_put('test', 0)
    increment_global('test', 1)
    increment_global('test', 1)
    increment_global('test', 1)
  end
end

approval = Approval.new
approval.compile_source
puts approval.teal