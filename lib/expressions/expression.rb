module TEALrb
  class Expression
    attr_reader :teal

    TEALrb::BINARY_METHODS.each do |meth, klass|
      define_method(meth) do |other|
        TEALrb::Expressions::Binary.const_get(klass).new self, other
      end
    end

    TEALrb::UNARY_METHODS.each do |meth, klass|
      define_method(meth) do
        TEALrb::Expressions::Unary.const_get(klass).new self
      end
    end
  end
end
