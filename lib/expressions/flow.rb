module TEALrb
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

  class Callsub < Expression
    def initialize(name, *args)
      @teal = [args.map(&:teal), "callsub #{name}"].flatten
    end
  end

  def callsub(name, *args)
    Callsub.new(name, *args)
  end
end
