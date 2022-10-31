module TEALrb
  class Logs < OpcodeType
    def [](_index)
      @contract.txnas 'Logs'
    end
  end
end
