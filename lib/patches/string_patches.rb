module TEALrb
  module Patches
    module StringPatches
    include TEALrb::Expressions::Types
      def teal
        byte(self).teal
      end
    end
  end
end

class String
  prepend TEALrb::Patches::StringPatches
end
