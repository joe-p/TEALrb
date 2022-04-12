module TEALrb
  class AppOptedIn < Expression
    def initialize(account = nil, app = nil)
      @teal = [account.teal, app.teal, 'app_opted_in']
    end
  end

  def app_opted_in(account = nil, app = nil)
    AppOptedIn.new(account, app)
  end

  class Global < Expression
    def self.current_application_address
      new 'CurrentApplicationAddress'
    end

    def self.latest_timestamp
      new 'LatestTimestamp'
    end

    def initialize(field)
      @teal = ["global #{field}"]
    end
  end

  def global(field)
    Global.new(field)
  end
end
