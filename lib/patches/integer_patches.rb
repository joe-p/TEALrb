module TEALrb
  module IntegerMethods
    def teal
      TEALrb::Int.new(self).teal
    end

    TEALrb::BINARY_METHODS.each do |meth, klass|
      define_method(meth) do |other|
        from_eval = caller[0].include? "(eval):1:in `teal_eval'"

        if from_eval
          TEALrb.const_get(klass).new self, other
        else
          super(other)
        end
      end
    end

    TEALrb::UNARY_METHODS.each do |meth, klass|
      define_method(meth) do
        from_eval = caller[0].include? "(eval):1:in `teal_eval'"

        if from_eval
          TEALrb.const_get(klass).new self
        else
          super()
        end
      end
    end

  end
end

class Integer
  prepend TEALrb::IntegerMethods
end
