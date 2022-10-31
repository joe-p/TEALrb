module TEALrb
  module ByteOpcodes
    def byte_b64(b64)
      @teal << "byte b64 #{b64}"
    end

    def byte_b32(b32)
      @teal << "byte b32 #{b32}"
    end
  end
end
