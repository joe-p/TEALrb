module TEALrb
  module Patches
    module StringPatches
      include TEALrb::Opcodes::Types
      def teal
        byte(self).teal
      end
    end
  end
end

class String
  prepend TEALrb::Patches::StringPatches
end
