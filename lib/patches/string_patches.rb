module TEALrb
  module Patches
    module StringPatches
      def teal
        TEALrb::Expressions::Types::Byte.new(self).teal
      end
    end
  end
end

class String
  prepend TEALrb::Patches::StringPatches
end
