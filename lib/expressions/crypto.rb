module TEALrb
  class Sha256 < Expression
    def initialize(input = nil)
      @teal = TEAL.new [input.teal, 'sha256']
    end
  end

  def sha256(input = nil)
    Sha256.new(input)
  end

  class Keccak256 < Expression
    def initialize(input = nil)
      @teal = TEAL.new [input.teal, 'keccak256']
    end
  end

  def keccak256(input = nil)
    Keccak256.new(input)
  end

  class SHA512_256 < Expression
    def initialize(input = nil)
      @teal = TEAL.new [input.teal, 'sha512_256']
    end
  end

  def sha512_256(input = nil)
    SHA512_256.new(input)
  end

  class Ed25519Verify < Expression
    def initialize(input = nil)
      @teal = TEAL.new [input.teal, 'ed25519verify']
    end
  end

  def ed25519verify(input = nil)
    Ed25519Verify.new(input)
  end

  class EcdsaVerify < Expression
    def initialize(_index, input = nil)
      @teal = TEAL.new [input.teal, 'ecdsa_verify #{index}']
    end
  end

  def ecdsa_verify(index, input = nil)
    EcdsaVerify.new(index, input)
  end

  class EcdsaPkDecompress < Expression
    def initialize(_index, input = nil)
      @teal = TEAL.new [input.teal, 'ecdsa_pk_decompress #{index}']
    end
  end

  def ecdsa_pk_decompress(index, input = nil)
    EcdsaPkDecompress.new(index, input)
  end

  class EcdsaPkRecover < Expression
    def initialize(_index, input = nil)
      @teal = TEAL.new [input.teal, 'ecdsa_pk_recover #{index}']
    end
  end

  def ecdsa_pk_recover(index, input = nil)
    EcdsaPkRecover.new(index, input)
  end
end
