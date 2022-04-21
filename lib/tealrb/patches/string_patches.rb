# frozen_string_literal: true

module TEALrb
  module Patches
    module StringPatches
      def teal
        ExtendedOpcodes.byte(self).teal
      end
    end
  end
end

class String
  prepend TEALrb::Patches::StringPatches
end
