require 'byebug'
require 'colorize'

class Tile
  attr_accessor :value, :given

  def initialize(value)
    @value = value.to_i
    @given = !(@value == 0)
  end

  def to_s
    # debugger
    @given ? @value.to_s : @value.to_s.colorize(:blue)

  end
end
