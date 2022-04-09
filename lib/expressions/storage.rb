module TEALrb
  class Store < Expression
    def initialize(index, value)
      @teal = [value.teal, "store #{index}"]
    end
  end

  def store(index, value = nil)
    Store.new(index, value)
  end

  class Load < Expression
    def initialize(index)
      @teal = ["load #{index}"]
    end
  end

  def load(index = nil)
    Load.new(index)
  end
end
