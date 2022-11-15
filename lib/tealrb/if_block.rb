# frozen_string_literal: true

module TEALrb
  module IfMethods
    def teal_if(_cond, &blk)
      @if_count ||= -1
      @if_count += 1
      @else_count = 0
      @end_label = "if#{@if_count}_end:"

      @teal << "bz if#{@if_count}_else0"
      blk.call
      @teal << "b if#{@if_count}_end"
      @teal << "if#{@if_count}_else0:"
      @teal << @end_label
      self
    end

    def elsif(_cond, &blk)
      @else_count += 1
      @teal.delete @end_label
      @teal << "bz if#{@if_count}_else#{@else_count}"
      blk.call
      @teal << "b if#{@if_count}_end"
      @teal << "if#{@if_count}_else#{@else_count}:"
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
