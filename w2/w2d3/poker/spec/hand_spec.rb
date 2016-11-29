require 'rspec'
require 'hand'


describe 'Hand' do
  let(:card) { double(value: 9, suit: :hearts) }
  let(:card1) { double(value: 10, suit: :hearts) }
  let(:card2) { double(value: 4, suit: :hearts) }
  let(:card3) { double(value: 3, suit: :hearts) }
  let(:card4) { double(value: 10, suit: :hearts) }
  let(:card5) { double(value: :K, suit: :clubs) }
  let(:card6) { double(value: 3, suit: :clubs) }
  let(:card7) { double(value: 5, suit: :clubs) }
  let(:card8) { double(value: 6, suit: :diamonds) }
  let(:card9) { double(value: 7, suit: :spades) }
  let(:card10) { double(value: 3, suit: :spades) }
  let(:card11) { double(value: 3, suit: :diamonds)}

  subject(:hand) { Hand.new(Array.new(5) { card }) }
  describe '#initializie' do

    it 'accepts an array of five cards' do
      expect(hand.cards.length).to eq(5)
    end
  end

  describe '#pair' do

    subject(:hand1) { Hand.new([card1, card2, card3, card4, card5]) }
    it 'returns array with card value of the pair' do
      expect(hand1.pair).to eq([10])
    end

    subject(:hand2) { Hand.new([card1, card2, card3, card4, card6])}
    it 'returns multiple pairs' do
      expect(hand2.pair).to eq([3, 10])

    end

    subject(:hand3) { Hand.new([card1, card2, card3, card5, card]) }
    it 'returns empty array if no pairs' do
      expect(hand3.pair).to eq([])
    end

  end

  describe '#straight' do
    subject(:hand4) { Hand.new([card9, card2, card3, card5, card]) }

    it 'returns nil if no straight' do
      expect(hand4.straight).to eq(nil)
    end

    subject(:hand5) { Hand.new([card3, card2, card7, card8, card9]) }
    it 'returns the value in high card if straight' do
      expect(hand5.straight).to eq(7)
    end
  end

  describe '#three_of_a_kind' do
    subject(:hand6) { Hand.new([card3, card2, card6, card10, card]) }
    it 'return the value in high card for three_of_a_kind' do
      expect(hand6.three_of_a_kind).to eq([3])
    end

    subject(:hand1) { Hand.new([card1, card2, card3, card4, card5]) }
    it 'return empty array if no three_of_a_kind' do
      expect(hand1.three_of_a_kind).to eq([])
    end
  end

  describe '#four_pair' do
    subject(:hand6) { Hand.new([card3, card2, card6, card10, card11]) }
    it 'return the value for the cards' do
      expect(hand6.four_pair).to eq([3])
    end

    subject(:hand1) { Hand.new([card1, card2, card3, card4, card5]) }
    it 'return empty array if no four_pair' do
      expect(hand1.four_pair).to eq([])
    end
  end

  describe '#flush' do
    subject(:hand7) { Hand.new([card3, card2, card1, card4, card]) }
    it 'return the high card value if flush' do
      expect(hand7.flush).to eq(10)
    end

    subject(:hand1) { Hand.new([card1, card2, card3, card, card5]) }
    it 'return nil if no flush' do
      expect(hand1.flush).to eq(nil)
    end
  end
end
