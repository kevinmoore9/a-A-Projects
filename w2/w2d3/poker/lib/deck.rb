require_relative 'card'

class Deck
  attr_reader :shoe

  VALUE = [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A].freeze
  SUIT = [:clubs, :spades, :hearts, :diamonds].freeze

  def initialize
    @shoe = new_deck.shuffle!

  end

  def draw(num)
    cards = shoe.take(num)
    @shoe = @shoe.drop(num)
    cards
  end

  def shuffle!
    @shoe.shuffle!
  end

  private

  def new_deck
    deck = []

    SUIT.each do |suit|
      VALUE.each do |val|
        deck << Card.new(val, suit)
      end
    end
    deck
  end


end
