# This is just a file used during development for generating code for opcodes
# It will be delted once 100% of opcodes are covered

ops = {
  EcdsaVerify: 'ecdsa_verify',
  EcdsaPkDecompress: 'ecdsa_pk_decompress',
  EcdsaPkRecover: 'ecdsa_pk_recover'
}

ops.each do |klass, method|
  puts ''"class #{klass} < Expression
    def initialize(index, input = nil)
        @teal = TEAL.new [input.teal, '#{method} \#{index}']
      end
    end

    def #{method}(index, input = nil)
      #{klass}.new(index, input)
    end"''
end
