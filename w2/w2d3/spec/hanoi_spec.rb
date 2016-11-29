require 'rspec'
require 'hanoi'

describe 'Towers of Hanoi' do

  describe '#initialize' do
    subject(:hanoi) { Hanoi.new(4) }

    it 'takes in a tower height' do
      expect(hanoi.height).to eq(4)
    end

    it 'initializes three towers' do
      expect(hanoi.towers.length).to eq(3)
    end

    it 'sets the first tower to length of height' do
      expect(hanoi.towers[0].length).to eq(4)
    end

    it 'first tower is sorted in decending order' do
      expect(hanoi.towers[0].reverse).to eq(hanoi.towers[0].sort)
    end
  end

  describe '#move' do
    subject(:hanoi) { Hanoi.new(4) }
    before(:each) { hanoi.move(0, 1) }
    it 'moves the top disc to selected tower' do
      expect(hanoi.towers).to eq([[3, 2, 1], [0], []])
    end

    it 'raise error if disc is bigger than last disc in selected tower' do
      expect { hanoi.move(0, 1) }.to raise_error(ArgumentError)
    end

    it 'raise error if start tower has empty disc' do
      expect { hanoi.move(2, 1) }.to raise_error(ArgumentError)
    end
  end

  describe '#won?' do
    subject(:hanoi) { Hanoi.new(3) }

    it 'returns false if discs on multiple towers' do
      hanoi.move(0, 1)
      hanoi.move(0, 2)
      expect(hanoi.won?).to eq(false)
    end

    it 'returns false if all discs are on first tower' do
      expect(hanoi.won?).to eq(false)
    end

    it 'return true if all discs on single tower execpt first' do
      hanoi.move(0, 1)
      hanoi.move(0, 2)
      hanoi.move(1, 2)
      hanoi.move(0, 1)
      hanoi.move(2, 0)
      hanoi.move(2, 1)
      hanoi.move(0, 1)
      expect(hanoi.won?).to eq(true)
    end
  end
end
