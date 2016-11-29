require_relative 'board'
require_relative 'card'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @board.populate
    @previous_guess = nil
  end

  def play
    until won?
      take_turn
    end
    puts "You are a winner!!!"
  end

  def take_turn
    first_guess = get_guess
    @board.reveal(first_guess)

    second_guess = get_guess
    @board.reveal(second_guess)

    unless @board[first_guess] == @board[second_guess]
      @board[first_guess].hide
      @board[second_guess].hide
      sleep(2)
    end
    @board.render

  end

  def get_guess
    puts "Enter a positon: row, col"
    begin
      guess = gets.chomp
      row, col = guess[0].to_i, guess[-1].to_i
      pos = [row, col]
      raise unless valid_guess?(pos)
    rescue
      puts "Invalid Guess. Guess again:"
      retry
    end
    pos
  end

  def valid_guess?(pos)
    return false unless (0...@board.grid.length).cover?(pos[0]) &&
      (0...@board.grid.length).cover?(pos[1])
    return false if @board[pos].face
    true
  end

  def won?
    @board.grid.flatten.all?(&:face)
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
