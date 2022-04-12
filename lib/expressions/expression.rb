module TEALrb
  class Expression
    attr_reader :teal

    TEALrb::BINARY_METHODS.each do |meth, klass|
      define_method(meth) do |other|
        TEALrb.const_get(klass).new self, other
      end
    end

    TEALrb::UNARY_METHODS.each do |meth, klass|
      define_method(meth) do
        TEALrb.const_get(klass).new self
      end
    end
  end
end
