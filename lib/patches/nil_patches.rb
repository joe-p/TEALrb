module TEALrb
  module Patches
    module NilMethods
      def teal; end
    end
  end
end

class NilClass
  prepend TEALrb::Patches::NilMethods
end
