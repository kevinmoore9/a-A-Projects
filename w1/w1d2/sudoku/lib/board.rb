require_relative 'tile'
require 'colorize'
require 'byebug'

class Board
  HORIZONTAL_LINE = ("=" * 38).colorize(:red)
  attr_reader :grid

  def initialize(grid = nil)
    @grid ||= self.class.from_file(grid)

  end

  def self.from_file(file)
    grid = File.new(file).readlines.map { |line| line.chomp.split("") }
    grid.each do |line|
      line.map! { |ch| Tile.new(ch) }
    end
  end

  def render
    display = "\n"
    @grid.each_with_index do |line, idx|
      display << render_line(line)
      display << HORIZONTAL_LINE + "\n" if (idx == 2) || (idx == 5)
    end
    puts display
  end

  def render_line(line)
    # debugger
    display = ""
    display_chrs = line.map { |ch| ch.value.zero? ? "_" : ch }
    display_chrs.each.with_index do |ch, idx|
      if (idx == 2) || (idx == 5)
        display << " #{ch} ||"
      else
        display << " #{ch} |"
      end
    end

    display << "\n"
    display.gsub("||", "||".colorize(:red))
  end

  def complete?(arr)
    arr = arr.map(&:value)
    # (1..9).to_a
    arr.sort == "123456789".split("").map(&:to_i)
  end

  def solved?
    9.times do |idx|
      return false unless solved_row?(idx)
      return false unless solved_col?(idx)
    end

    3.times do |i|
      3.times do |j|
        return false unless solved_square?(3 * i, 3 * j)
      end
    end
    true
  end

  def solved_row?(idx)
    complete?(@grid[idx])
  end

  def solved_col?(idx)
    col = []
    @grid.each { |row| col << row[idx] }
    complete?(col)
  end

  def solved_square?(row, col)
    square = []
    3.times do |i|
      3.times do |j|
        square << @grid[row + i][col + j]
      end
    end
    complete?(square)
  end

end
