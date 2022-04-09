module TEALrb
  module IntegerMethods
    def teal
      TEALrb::Int.new(self).teal
    end

    TEALrb::METHOD_CLASS_HASH.each do |meth, klass|
      define_method(meth) do |other|
        from_eval = caller.join.include? TEALrb::Compiler.class_variable_get :@@eval_location
        from_pry = caller.join.include? 'pry'

        if from_eval and !from_pry
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
