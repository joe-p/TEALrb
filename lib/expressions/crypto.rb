module TEALrb
  class Sha256 < Expression
    def initialize(input = nil)
      @teal = TEAL.new [input.teal, 'sha256']
    end
  end

  def sha256(input = nil)
    Sha256.new(input)
  end
end
