module TEALrb
  class Err < Expression
    def initialize
      @teal = ['err']
    end
  end

  def err
    Err.new
  end
end
