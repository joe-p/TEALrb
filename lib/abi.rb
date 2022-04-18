require 'json'

module TEALrb
  module Networks
    def self.mainnet
      'wGHE2Pwdvd7S12BL5FaOP20EGYesN73ktiC1qzkkit8='
    end
  end

  class ABIType
    def initialize(type)
      @type = type
    end

    def [](n)
      ABIType.new "#{@type}[#{n}]"
    end

    def to_s
      @type
    end
  end

  module ABITypes
    def uint64
      ABIType.new 'uint64'
    end
  end

  class ABI
    attr_accessor :name
    attr_reader :methods

    def initialize
      @name = ''
      @networks = {}
      @methods = []
    end

    def add_method(name:, desc:, args:, returns:)
      @methods << {
        name: name,
        desc: desc,
        args: args,
        returns: { type: returns }
      }
    end

    def add_id(network, id)
      @networks[network] = { appID: id }
    end

    def to_h
      {
        'name' => @name,
        'networks' => @networks,
        'methods' => @methods
      }
    end
  end
end
