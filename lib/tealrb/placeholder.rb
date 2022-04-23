# frozen_string_literal: true

module TEALrb
  class Placeholder < String
    def teal
      [self]
    end
  end
end
