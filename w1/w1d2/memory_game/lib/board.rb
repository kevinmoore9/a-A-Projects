require 'byebug'
require_relative 'card'

class Board
  DEFAULT_SIZE = 4
  BACK = "⬜"
  CARDS = ["🏈", "😎", "😍", "🎁", "😥", "🏄", "🐷", "🚴", "😷", "👺",
          "💀", "🤖", "👻", "👽", "💩", "🙉", "👏", "👮", "🕵", "💂"].freeze
  attr_reader :grid

  def initialize
    @grid = Array.new(DEFAULT_SIZE) { Array.new(DEFAULT_SIZE) }
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    grid[row][col] = mark
  end

  def populate
    cards = []
    num_pairs = @grid.length * @grid.length / 2
    cards = CARDS.sample(num_pairs)
    cards += cards.shuffle

    @grid.length.times do |i|
      @grid.length.times do |j|
        self[[i, j]] = Card.new(cards[@grid.length * i + j])
      end
    end
  end

  def render
    system('clear')
    display = " "
    DEFAULT_SIZE.times { |i| display << " #{i} " }
    display << "\n"

    @grid.each_with_index do |g, idx|
      display << idx.to_s
      g.each do |card|
        card.face ? display << " #{card} " : display << " #{BACK} "
      end
      display << "\n"
    end
    puts display
  end

  def reveal(guessed_pos)
    self[guessed_pos].reveal
    render
  end


end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.populate
  board.reveal([1,1])
end
