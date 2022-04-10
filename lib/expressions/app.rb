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
      @teal = [key.teal, value.teal, 'app_global_put']
    end
  end

  def app_global_put(key = nil, value = nil)
    AppGlobalPut.new(key, value)
  end

  class Txn < Expression
    def self.application_id
      new 'ApplicationID'
    end

    def self.sender
      new 'Sender'
    end

    def initialize(field)
      @teal = ["txn #{field}"]
    end
  end

  def txn(field)
    Txn.new(field)
  end

  class Gtxn < Expression
    def self.application_id(index)
      new index, 'ApplicationID'
    end

    def self.sender(index)
      new index, 'Sender'
    end

    def self.receiver(index)
      new index, 'Receiver'
    end

    def self.amount(index)
      new index, 'Amount'
    end

    def self.[](index)
      GroupTransaction.new(index)
    end

    def initialize(index, field)
      @teal = ["gtxn #{index} #{field}"]
    end
  end

  def gtxn(index, field)
    Gtxn.new(index, field)
  end

  class GroupTransaction
    def initialize(index)
      @index = index
    end

    GTXN_METHODS = [
      :sender,
      :receiver,
      :application_id, 
      :amount
    ]

    GTXN_METHODS.each do |meth|
      define_method meth do
        Gtxn.send(meth, @index)
      end
    end

  end

  class Txna < Expression
    def self.application_args(index)
      new 'ApplicationArgs', index
    end

    def initialize(field, index)
      @teal = ["txna #{field} #{index}"]
    end
  end

  def txna(field)
    Txna.new(field)
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
