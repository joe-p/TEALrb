# frozen_string_literal: true

module TEALrb
  module Patches
    module SymbolMethods
      def teal
        "#{self}:"
      end
    end
  end
end

class Symbol
  prepend TEALrb::Patches::SymbolMethods
end
