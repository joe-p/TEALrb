# frozen_string_literal: true

module TEALrb
  class Scratch
    class << self
      attr_accessor :instance
    end

    def initialize
      @open_slots = (0..256).to_a
      @named_slots = {}
      self.class.instance = self
    end

    def [](key)
      TEAL.instance << "load #{@named_slots[key]} // #{key}"
    end

    def []=(key, _value)
      store(key)
    end

    def store(key)
      TEAL.instance << "store #{@named_slots[key] ||= @open_slots.shift} // #{key}"
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
