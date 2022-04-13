module TEALrb
  class Not < Expression
    def initialize(expr)
      @teal = [expr.teal, '!']
    end
  end

  def not(expr = nil)
    Not.new
  end
end
