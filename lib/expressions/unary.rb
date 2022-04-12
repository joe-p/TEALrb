module TEALrb
  class Not < Expression
    def initialize(expr)
      @teal = [expr.teal, '!']
    end
  end

  def not
    Not.new
  end
end
