module TEALrb
  module StringPatches
    def teal
      TEALrb::Bytes.new(self).teal
    end
  end
end

class String
  prepend TEALrb::StringPatches
end
