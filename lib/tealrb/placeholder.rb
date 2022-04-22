module TEALrb
    class Placeholder < String
      def teal
        [self]
      end
    end
end