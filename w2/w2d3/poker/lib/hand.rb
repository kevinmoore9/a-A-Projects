require_relative 'deck'

class Hand
  TRUE_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A].freeze

  HAND_RANKINGS = [
    "Straight Flush",
    "Four of a Kind",
    "Full House",
    "Flush",
    "Straight",
    "Three of a Kind",
    "Two Pairs",
    "Pair",
    "High Card"
  ].freeze

  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def categorize_hand
    rank = nil
    high_card = nil

    # handles SF, straight, flush

    if straight != nil
      if flush !=  nil
        rank = "Straight Flush"
      else
        rank = "Straight"
      end
      high_card = straight

    elsif flush != nil
      rank = "Flush"
      high_card = flush

    elsif four_pair != []
      rank = "Four Pair"
      high_card = four_pair[0]

    elsif three_of_a_kind != []
      if pair != []
        rank = "Full House"
      else
        rank = "Three of a Kind"
      end
      high_card = three_of_a_kind[0]

    elsif pair != []
      if pair.length == 2
        rank = "Two Pair"
      else
      rank = "Pair"
    end
      high_card = pair[-1]
    else
      sorted = cards.sort_by { |el| TRUE_VALUES.index(el.value) }
      high_card = sorted[-1].value
      rank = "High Card"
    end
    [rank, high_card]
  end

  def pair
    values = Hash.new {|h, k| h[k] = []}

    cards.each do |card|
      values[card.value] << card
    end
    pairs = values.select { |_, occurances| occurances.length == 2 }

    pairs.sort.map {|card| card[0] }

  end


  def three_of_a_kind
    values = Hash.new {|h, k| h[k] = []}

    cards.each do |card|
      values[card.value] << card
    end
    pairs = values.select { |_, occurances| occurances.length == 3 }

    pairs.sort.map {|card| card[0] }

  end

  def four_pair
    values = Hash.new {|h, k| h[k] = []}

    cards.each do |card|
      values[card.value] << card
    end
    pairs = values.select { |_, occurances| occurances.length == 4 }

    pairs.sort.map {|card| card[0] }

  end

  def straight
    sorted = cards.sort_by { |el| TRUE_VALUES.index(el.value) }
    first_val = sorted[0].value
    last_val = sorted[-1].value

    return last_val if TRUE_VALUES.index(last_val) - TRUE_VALUES.index(first_val) == 4
    nil
  end

  def flush
    if cards.all? { |card| card.suit == cards[0].suit }
      last_card = cards.sort_by { |el| TRUE_VALUES.index(el.value) }[-1]
      return last_card.value
    end
    nil
  end

end

if $PROGRAM_NAME == __FILE__
  card1 = Card.new(5, :spades)
  card2 = Card.new(7, :hearts)
  card3 = Card.new(7, :diamonds)
  card4 = Card.new(:K, :diamonds)
  card5 = Card.new(7, :spades)

  hand = Hand.new([card1, card2, card3, card4, card5])

  p hand.categorize_hand
end
