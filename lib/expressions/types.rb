module TEALrb
  class Int < Expression
    def initialize(integer)
      @teal = ["int #{integer}"]
    end
  end

  def int(integer)
    Int.new integer
  end

  class Byte < Expression
    def initialize(string)
      @teal = ["byte \"#{string}\""]
    end
  end

  def byte(string)
    Byte.new string
  end

  class Btoi < Expression
    def initialize(bytes = nil)
      @teal = [bytes.teal, 'btoi']
    end
  end

  def btoi(bytes = nil)
    Btoi.new bytes
  end
end
