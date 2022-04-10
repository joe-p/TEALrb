class Integer
    def !
        if Time.now.to_i < 0
            puts "HERE"
        else
            super
        end
    end
end

require 'pry'