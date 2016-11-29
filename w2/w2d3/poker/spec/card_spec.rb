require 'rspec'
require 'card'

describe 'Card' do
  describe '#initialize' do
    subject(:card) { Card.new(10, :hearts) }
    it 'initilaize value and suit' do
      expect(card.value).to eq(10)
      expect(card.suit).to eq(:hearts)
    end
  end

end
