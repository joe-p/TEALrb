module TEALrb
  module Expressions
    module Crypto
      def sha256(input = nil)
        TEAL.new [input.teal, 'sha256']      
      end

      def keccak256(input = nil)
        TEAL.new [input.teal, 'keccak256']
      end

      def sha512_256(input = nil)
        TEAL.new [input.teal, 'sha512_256']
      end

      def ed25519verify(input = nil)
        TEAL.new [input.teal, 'ed25519verify']
      end

      def ecdsa_verify(index, input = nil)
        TEAL.new [input.teal, "ecdsa_verify #{index}"]
      end

      def ecdsa_pk_decompress(index, input = nil)
        TEAL.new [input.teal, "ecdsa_pk_decompress #{index}"]
      end

      def ecdsa_pk_recover(index, input = nil)
        TEAL.new [input.teal, "ecdsa_pk_recover #{index}"]
      end
    end
  end
end
