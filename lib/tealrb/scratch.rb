# frozen_string_literal: true

module TEALrb
  class Scratch
    def initialize
      @open_slots = (0..256).to_a
      @named_slots = {}
      @values = {}
    end

    def [](key)
      TEAL.instance << "load #{@named_slots[key]} // #{key}"
      @values[key]
    end

    def []=(key, value)
      store(key, value)
    end

    def store(key, value = TEAL.instance)
      @values[key] = value
      TEAL.instance << "store #{@named_slots[key] ||= @open_slots.shift} // #{key}"
    end

    def delete(key)
      @values.delete(key)
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
