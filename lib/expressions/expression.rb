module TEALrb
  class Expression
    attr_reader :teal
    
    TEALrb::METHOD_CLASS_HASH.each do |meth, klass|
      define_method(meth) do |other|
          TEALrb.const_get(klass).new self, other
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
      @teal = ["bytes \"#{string}\""]
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

  def approve()
    Approve.new
  end


end
