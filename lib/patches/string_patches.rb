# frozen_string_literal: true

module TEALrb
  module Patches
    module StringPatches
      include TEALrb::Opcodes
      def teal
        byte(self).teal
      end
    end
  end
end

class String
  prepend TEALrb::Patches::StringPatches
end
