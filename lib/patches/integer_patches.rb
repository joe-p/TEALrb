module TEALrb
  module IntegerMethods
    def teal
      TEALrb::Int.new(self).teal
    end

    TEALrb::METHOD_CLASS_HASH.each do |meth, klass|
      define_method(meth) do |other|
        from_eval = caller[0].include? "(eval):1:in `teal_eval'"

        if from_eval
          TEALrb.const_get(klass).new self, other
        else
          super(other)
        end
      end
    end
  end
end

class Integer
  prepend TEALrb::IntegerMethods
end
