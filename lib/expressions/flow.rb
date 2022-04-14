module TEALrb
  class Approve < Expression
    def initialize
      @teal = TEAL.new [1.teal, 'return']
    end
  end

  def approve
    Approve.new
  end

  class Err < Expression
    def initialize
      @teal = TEAL.new ['err']
    end
  end

  def err
    Err.new
  end

  class Callsub < Expression
    def initialize(name, *args)
      @teal = TEAL.new [args.map(&:teal), "callsub #{name}"].flatten
    end
  end

  def callsub(name, *args)
    Callsub.new(name, *args)
  end

  class Log < Expression
    def initialize(data)
      @teal = TEAL.new [data.teal, 'log']
    end
  end

  def log(data = nil)
    Log.new(data)
  end

  def abi_return(data)
    log(concat('151f7c75', data.teal).teal)
  end
end
