require 'rspec'
require 'deck'
require 'card'

describe 'Deck' do
  subject(:new_deck) { Deck.new }

  describe '#initialize' do
    #(:cards) { double(value, suit) }
    it 'sets shoe to 52 cards' do
      expect(new_deck.shoe.length).to eq(52)
    end

    it 'has no duplicate cards' do
      expect(new_deck.shoe.uniq.length).to eq(52)
    end

    it 'has 4 cards of each value' do
      freq = Hash.new(0)
      new_deck.shoe.each do |card|
        freq[card.value] += 1
      end
      expect(freq.values.all? { |val| val == 4 }).to eq(true)
    end

    it 'has 13 cards for each suit' do
      freq = Hash.new(0)
      new_deck.shoe.each do |card|
        freq[card.suit] += 1
      end
      expect(freq.values.all? { |val| val == 13 }).to eq(true)
    end
  end

  describe '#draw' do
    before(:each) { new_deck.draw(5) }
    it 'return an array of random card' do
      expect(new_deck.draw(5).length).to eq(5)
    end

    it 'remove the return cards from shoe' do
      expect(new_deck.shoe.length).to eq(47)
    end
  end

  describe '#shuffle' do
    it 'shuffle the cards' do
      cards = new_deck.shoe.dup
      new_deck.shuffle!
      expect(new_deck.shoe).not_to eq(cards)
    end
  end
end
