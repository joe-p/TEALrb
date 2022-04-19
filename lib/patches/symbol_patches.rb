module TEALrb
  module Patches
    module SymbolMethods
      def teal
        to_s + ':'
      end
    end
  end
end

class Symbol
  prepend TEALrb::Patches::SymbolMethods
end
