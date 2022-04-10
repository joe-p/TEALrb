module TEALrb
  class Expression
    attr_reader :teal
    
    TEALrb::BINARY_METHODS.each do |meth, klass|
      define_method(meth) do |other|
          TEALrb.const_get(klass).new self, other
      end
    end

    TEALrb::UNARY_METHODS.each do |meth, klass|
      define_method(meth) do
          TEALrb.const_get(klass).new self
      end
    end
  end

  class Int < Expression
    def initialize(integer)
      @teal = ["int #{integer}"]
    end
  end

  class Bytes < Expression
    def initialize(string)
      @teal = ["byte \"#{string}\""]
    end
  end

  class Btoi < Expression
    def initialize(bytes = nil)
      @teal = [bytes.teal, 'btoi']
    end
  end

  def btoi(bytes = nil)
    Btoi.new bytes
  end

  class Approve < Expression
    def initialize
      @teal = [1.teal, 'return']
    end
  end

  def approve
    Approve.new
  end

  class Err < Expression
    def initialize
      @teal = ['err']
    end
  end

  def err
    Err.new
  end

  class Not < Expression
    def initialize(expr)
      @teal = [expr.teal, '!']
    end
  end

  def not
    Not.new
  end

end
