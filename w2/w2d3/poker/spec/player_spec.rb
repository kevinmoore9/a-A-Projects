require 'rspec'
require 'player'

describe 'Player' do
  let(:card0) { double(value: 9, suit: :hearts) }
  let(:card1) { double(value: 10, suit: :hearts) }
  let(:card2) { double(value: 4, suit: :hearts) }
  let(:card3) { double(value: 3, suit: :hearts) }
  let(:card4) { double(value: 10, suit: :hearts) }
  let(:hand) { [card0, card1, card2, card3, card4] }
  subject(:player) { Player.new("Kevin", hand, 10000) }

  describe '#initialize' do

    it 'assign a name and money to a player' do
      expect(player.name).to eq("Kevin")
      expect(player.money).to eq(10000)
    end

    it 'set default money if money is not given' do
      player = Player.new("Kevin", hand)
      expect(player.money).to eq(1000)
    end

    it 'set the money in pot' do
      expect(player.in_pot).to eq(0)
    end

    it 'gets hand from game' do
      expect(player.hand.length).to eq(5)
    end
  end
end
