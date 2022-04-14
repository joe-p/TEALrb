module TEALrb
  class Concat < Expression
    def initialize(a, b)
      @teal = TEAL.new [a.teal, b.teal, 'concat']
    end
  end

  def concat(a = nil, b = nil)
    Concat.new a, b
  end
end
