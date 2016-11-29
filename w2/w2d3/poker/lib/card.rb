class Card
  TRUE_VALUES = [3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A]

  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def <=>(other_card)
    TRUE_VALUES.index(self.value) <=> TRUE_VALUES.index(other_card.value)
  end
end

if $PROGRAM_NAME == __FILE__
  card1 = Card.new(5, :spades)
  card2 = Card.new(7, :hearts)
  card3 = Card.new(7, :diamonds)
  card4 = Card.new(:K, :diamonds)

  p card1 <=> card2
  p card2 <=> card3
  p card3 <=> card4

  cards = [card1, card4, card2, card3]
  p cards.map {|card| card.value}
  p cards.sort.map {|card| card.value}
end
