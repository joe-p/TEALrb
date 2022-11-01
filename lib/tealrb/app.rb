module TEALrb
  class App < OpcodeType
    def initialize(contract)
      @field = 'Applications'
      super
    end

    # @return [[]byte] Bytecode of Approval Program
    def approval_program(*_args)
      @contract.app_param_value 'AppApprovalProgram'
    end

    # @return [[]byte] Bytecode of Clear State Program
    def clear_state_program(*_args)
      @contract.app_param_value 'AppClearStateProgram'
    end

    # @return [uint64] Number of uint64 values allowed in Global State
    def global_num_uint(*_args)
      @contract.app_param_value 'AppGlobalNumUint'
    end

    # @return [uint64] Number of byte array values allowed in Global State
    def global_num_byte_slice(*_args)
      @contract.app_param_value 'AppGlobalNumByteSlice'
    end

    # @return [uint64] Number of uint64 values allowed in Local State
    def local_num_uint(*_args)
      @contract.app_param_value 'AppLocalNumUint'
    end

    # @return [uint64] Number of byte array values allowed in Local State
    def local_num_byte_slice(*_args)
      @contract.app_param_value 'AppLocalNumByteSlice'
    end

    # @return [uint64] Number of Extra Program Pages of code space
    def extra_program_pages(*_args)
      @contract.app_param_value 'AppExtraProgramPages'
    end

    # @return [[]byte] Creator address
    def creator(*_args)
      @contract.app_param_value 'AppCreator'
    end

    # @return [[]byte] Address for which this application has authority
    def address(*_args)
      @contract.app_param_value 'AppAddress'
    end

    # @return [[]byte] Bytecode of Approval Program
    def approval_program?(*_args)
      @contract.app_param_exists? 'AppApprovalProgram'
    end

    # @return [[]byte] Bytecode of Clear State Program
    def clear_state_program?(*_args)
      @contract.app_param_exists? 'AppClearStateProgram'
    end

    # @return [uint64] Number of uint64 values allowed in Global State
    def global_num_uint?(*_args)
      @contract.app_param_exists? 'AppGlobalNumUint'
    end

    # @return [uint64] Number of byte array values allowed in Global State
    def global_num_byte_slice?(*_args)
      @contract.app_param_exists? 'AppGlobalNumByteSlice'
    end

    # @return [uint64] Number of uint64 values allowed in Local State
    def local_num_uint?(*_args)
      @contract.app_param_exists? 'AppLocalNumUint'
    end

    # @return [uint64] Number of byte array values allowed in Local State
    def local_num_byte_slice?(*_args)
      @contract.app_param_exists? 'AppLocalNumByteSlice'
    end

    # @return [uint64] Number of Extra Program Pages of code space
    def extra_program_pages?(*_args)
      @contract.app_param_exists? 'AppExtraProgramPages'
    end

    # @return [[]byte] Creator address
    def creator?(*_args)
      @contract.app_param_exists? 'AppCreator'
    end

    # @return [[]byte] Address for which this application has authority
    def address?(*_args)
      @contract.app_param_exists? 'AppAddress'
    end

    def num_approval_pages?
      @contract.app_param_exists? 'NumApprovalProgramPages'
    end

    def num_approval_pages
      @contract.app_param_value 'NumApprovalProgramPages'
    end

    def num_clear_pages?
      @contract.app_param_exists? 'NumClearProgramPages'
    end

    def num_clear_pages
      @contract.app_param_value 'NumClearProgramPages'
    end

    def global_value(_key)
      @contract.app_global_ex_value
    end

    def global_exists?(_key)
      @contract.app_global_ex_exists?
    end

    def local_value(_account, _key)
      @contract.app_local_ex_value
    end

    def local_exists?(_account, _key)
      @contract.app_local_ex_exists?
    end
  end
end
