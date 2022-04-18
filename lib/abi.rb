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

    def [](n = nil)
      ABIType.new "#{@type}[#{n}]"
    end

    def to_s
      @type
    end
  end

  module ABITypes
    def byte
      ABIType.new "byte"
    end

    def bool
      ABIType.new "bool"
    end

    def address
      ABIType.new "address"
    end

    def string
      ABIType.new "string"
    end

    def account
      ABIType.new "account"
    end

    def asset
      ABIType.new "asset"
    end

    def application
      ABIType.new "application"
    end

    (8..512).step(8) do |n|
      (0..160).each do |m|
        type = "ufixed#{n}x#{m}"
        
        define_method(type) do
          ABIType.new type
        end
      end
    end

    (8..512).step(8) do |n|
      type = "uint#{n}"
      
      define_method(type) do
        ABIType.new type
      end
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
