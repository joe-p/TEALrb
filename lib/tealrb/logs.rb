# frozen_string_literal: true

module TEALrb
  class Logs < OpcodeType
    def initialize(contract)
      @field = 'Logs'
      super
    end
  end
end
