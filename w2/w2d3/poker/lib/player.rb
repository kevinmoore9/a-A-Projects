require_relative 'hand'

class Player
  attr_reader :name, :money, :in_pot, :hand
  attr_accessor :fold

  def initialize(name, hand, money = 1000)
    @name = name
    @money = money
    @in_pot = 0
    @hand = hand
  end

  def prompt
    puts "Do you wish to fold, see, or raise"
    option = get.chomp
  end

  def fold
    fold = true
  end

  def call(bet)
    @in_pot += bet
    @money -= bet
  end

  def raise(bet)
    puts "What you want to raise"
    raise_money = gets.chomp.to_i
    
  end
  def see
  end

    when raise
      puts "Which cards you wish to discard?"
      discard_card = gets.chomp.split(" ").map(&:to_i)

    when see




  end
end
