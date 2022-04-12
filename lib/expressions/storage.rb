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

  class AppLocalGet < Expression
    def initialize(account = nil, key = nil)
      @teal = [account.teal, key.teal, 'app_local_get']
    end
  end

  def app_local_get(account = nil, key = nil)
    AppLocalGet.new(account, key)
  end

  class AppGlobalGet < Expression
    def initialize(key)
      @teal = [key.teal, 'app_global_get']
    end
  end

  def app_global_get(key = nil)
    AppGlobalGet.new(key)
  end

  class AppGlobalPut < Expression
    def initialize(key, value)
      @teal = [key.teal, value.teal, 'app_global_put']
    end
  end

  def app_global_put(key = nil, value = nil)
    AppGlobalPut.new(key, value)
  end
end
