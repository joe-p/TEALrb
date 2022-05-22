# frozen_string_literal: true

module TEALrb
  class Scratch
    def initialize(teal)
      @teal = teal
      @open_slots = (0..256).to_a
      @named_slots = {}
    end

    def [](key)
      @teal << "load #{@named_slots[key]} // #{key}"
    end

    def []=(key, _value)
      store(key)
    end

    def store(key)
      @teal << "store #{@named_slots[key] ||= @open_slots.shift} // #{key}"
    end

    def delete(key)
      @open_slots << @named_slots.delete(key)
    end

    def reserve(slot)
      name = @named_slots.key(slot)
      raise ArgumentError, "Attempted to reserve a slot (#{slot}) that corresponds to a named slot (#{name})" if name

      @open_slots.delete slot
    end

    def unreserve(slot)
      @open_slots << slot
    end
  end
end
