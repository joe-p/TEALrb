module TEALrb
  class Not < Expression
    def initialize(expr)
      @teal = TEAL.new [expr.teal, '!']
    end
  end

  def not(expr = nil)
    Not.new(expr)
  end
end
