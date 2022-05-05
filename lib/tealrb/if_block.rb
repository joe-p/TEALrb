# frozen_string_literal: true

module TEALrb
  class IfBlock
    class << self
      attr_accessor :id
    end

    @id = 0

    def initialize(teal, _cond, &blk)
      @teal = teal
      @else_count = 0
      @id = self.class.id
      @end_label = "if#{@id}_end:"

      @id = self.class.id
      self.class.id += 1

      @teal << "bz if#{@id}_else0"
      blk.call
      @teal << "b if#{@id}_end"
      @teal << "if#{@id}_else0:"
      @teal << @end_label
    end

    def elsif(_cond, &blk)
      @else_count += 1
      @teal.delete @end_label
      @teal << "bz if#{@id}_else#{@else_count}"
      blk.call
      @teal << "b if#{@id}_end"
      @teal << "if#{@id}_else#{@else_count}:"
      @teal << @end_label
      self
    end

    def else(&blk)
      @teal.delete @end_label
      blk.call
      @teal << @end_label
    end
  end
end