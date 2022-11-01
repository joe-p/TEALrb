module TEALrb
  class Global
    def initialize(contract)
      @contract = contract
    end

    def [](_key)
      @contract.app_global_get
    end

    def []=(_key, _value)
      @contract.app_global_put
    end

    # @return [uint64] microalgos (v1)
    def min_txn_fee(*args)
      @contract.global_opcode('MinTxnFee', *args)
    end

    # @return [uint64] microalgos (v1)
    def min_balance(*args)
      @contract.global_opcode('MinBalance', *args)
    end

    # @return [uint64] rounds (v1)
    def max_txn_life(*args)
      @contract.global_opcode('MaxTxnLife', *args)
    end

    # @return [[]byte] 32 byte address of all zero bytes (v1)
    def zero_address(*args)
      @contract.global_opcode('ZeroAddress', *args)
    end

    # @return [uint64] Number of transactions in this atomic transaction group. At least 1 (v1)
    def group_size(*args)
      @contract.global_opcode('GroupSize', *args)
    end

    # @return [uint64] Maximum supported version (v2)
    def logic_sig_version(*args)
      @contract.global_opcode('LogicSigVersion', *args)
    end

    # @return [uint64] Current round number. Application mode only. (v2)
    def round(*args)
      @contract.global_opcode('Round', *args)
    end

    # @return [uint64] Last confirmed block UNIX timestamp. Fails if negative. Application mode only. (v2)
    def latest_timestamp(*args)
      @contract.global_opcode('LatestTimestamp', *args)
    end

    # @return [uint64] ID of current application executing. Application mode only. (v2)
    def current_application_id(*args)
      @contract.global_opcode('CurrentApplicationID', *args)
    end

    # @return [[]byte] Address of the creator of the current application. Application mode only. (v3)
    def creator_address(*args)
      @contract.global_opcode('CreatorAddress', *args)
    end

    # @return [[]byte] Address that the current application controls. Application mode only. (v5)
    def current_application_address(*args)
      @contract.account @contract.global_opcode('CurrentApplicationAddress', *args)
    end

    # @return [[]byte] ID of the transaction group. 32 zero bytes if the transaction is not part of a group. (v5)
    def group_id(*args)
      @contract.global_opcode('GroupID', *args)
    end

    # @return [uint64] The remaining cost that can be spent by opcodes in this program. (v6)
    def opcode_budget(*args)
      @contract.global_opcode('OpcodeBudget', *args)
    end

    # @return [uint64] The application ID of the application that called this application.
    #   0 if this application is at the top-level. Application mode only. (v6)
    def caller_application_id(*args)
      @contract.app @contract.global_opcode('CallerApplicationID', *args)
    end

    # @return [[]byte] The application address of the application that called this application.
    #   ZeroAddress if this application is at the top-level. Application mode only. (v6)
    def caller_application_address(*args)
      @contract.global_opcode('CallerApplicationAddress', *args)
    end
  end
end
