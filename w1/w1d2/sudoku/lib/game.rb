require_relative 'board'
require_relative 'tile'
class Game
  attr_reader :board

  def initialize(file)
    @board = Board.new(file)
  end

  def get_tile
    puts "Enter a tile: row, col"
    pos = gets.chomp
    row, col = pos[0], pos[-1]
    [row.to_i, col.to_i]
  end

  def get_num
    puts "Enter a number:"
    gets.chomp.to_i
  end

  def play_game
    until @board.solved?
      self.take_turn
      puts @board.solved?
    end

    puts "You win!"
  end

  def take_turn
    system('clear')
    @board.render

    tile = get_tile
    num = get_num.abs

    if @board.grid[tile[0]][tile[1]].given #|| num > 9
      puts "Invalid move."
      self.take_turn
    else
      @board.grid[tile[0]][tile[1]].value = num
    end
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new("tests/sudoku1.txt")
  game.play_game
end
