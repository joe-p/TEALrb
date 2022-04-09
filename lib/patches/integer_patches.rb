module TEALrb
  module IntegerMethods
    def teal
      TEALrb::Int.new(self).teal
    end

    TEAL_CLASSES = {
      '+': TEALrb::Add,
      '-': TEALrb::Subtract,
      '<': TEALrb::LessThan,
      '>': TEALrb::GreaterThan,
      '<=': TEALrb::LessThanOrEqual,
      '>=': TEALrb::GreaterThanOrEqual,
      '/': TEALrb::Divide
    }

    TEAL_CLASSES.each do |meth, klass|
      define_method(meth) do |other|
        from_eval = caller.join.include? TEALrb::Compiler.class_variable_get :@@eval_location
        from_pry = caller.join.include? 'pry'

        if from_eval and !from_pry
          klass.new self, other
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
