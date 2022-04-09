module TEALrb
  class AppOptedIn < Expression
    def initialize(account = nil, app = nil)
      @teal = [account.teal, app.teal, 'app_opted_in']
    end
  end

  def app_opted_in(account = nil, app = nil)
    AppOptedIn.new(account, app)
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
      @teal = [value.teal, key.teal, 'app_global_put']
    end
  end

  def app_global_put(key = nil, value = nil)
    AppGlobalPut.new(key, value)
  end

  class Txn < Expression
    def self.application_id
      new 24
    end

    def initialize(field)
      @teal = ["txn #{field}"]
    end
  end

  def txn(field)
    Txn.new(field)
  end
end
