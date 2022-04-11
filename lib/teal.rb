require 'method_source'
require 'ostruct'

require_relative 'constants'
require_relative 'compiler'
require_relative 'expressions'
require_relative 'patches'

module TEALrb
  class If
    attr_accessor :blocks
    attr_reader :id

    def initialize(condition, id)
      @blocks = { condition => [] }
      @id = id
    end
  end
end

class NilClass
  def teal; end
end
