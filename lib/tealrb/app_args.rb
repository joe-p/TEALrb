module TEALrb
  class AppArgs < OpcodeType
    def [](_index)
      @contract.txnas 'ApplicationArgs'
    end
  end
end
