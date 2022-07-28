# frozen_string_literal: true

module TEALrb
  class IfBlock
    class << self
      attr_accessor :id
    end

    @id = 0

    def initialize(_cond, &blk)
      self.class.id ||= 0
      @else_count = 0
      @id = self.class.id
      @end_label = "if#{@id}_end:"

      self.class.id += 1

      TEAL.instance << "bz if#{@id}_else0"
      blk.call
      TEAL.instance << "b if#{@id}_end"
      TEAL.instance << "if#{@id}_else0:"
      TEAL.instance << @end_label
    end

    def elsif(_cond, &blk)
      @else_count += 1
      TEAL.instance.delete @end_label
      TEAL.instance << "bz if#{@id}_else#{@else_count}"
      blk.call
      TEAL.instance << "b if#{@id}_end"
      TEAL.instance << "if#{@id}_else#{@else_count}:"
      TEAL.instance << @end_label
      self
    end

    def else(&blk)
      TEAL.instance.delete @end_label
      blk.call
      TEAL.instance << @end_label
    end
  end
end
