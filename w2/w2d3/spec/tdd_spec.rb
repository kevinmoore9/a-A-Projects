require 'tdd'
require 'rspec'

describe Array do
  describe '#uniq' do
    subject(:arr) { arr = [1, 2, 1, 3, 3] }
    it 'returns an array with no duplicates' do
      expect(arr.my_uniq).to eq([1, 2, 3])
    end

    it 'handles and empty array' do
      arr = []
      expect(arr.my_uniq).to eq([])
    end
  end

  describe '#two_sum' do
    subject(:arr) { arr = [-1, 0, 2, -2, 1] }
    it 'find indices of elements sum to zero' do
      expect(arr.two_sum).to eq ([[0, 4], [2, 3]])
    end

    it 'return empty array if no elements add to zero' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.two_sum).to eq([])
    end

    it 'return empty array if array is empty' do
      arr = []
      expect(arr.two_sum).to eq([])
    end
  end

  describe '#my_transpose' do
    subject(:matrix) {matrix = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]}

    it 'transposes the matrix' do
      expect(matrix.my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end

  end

  describe '#stock_picker' do
    subject(:stock) { stock = [45, 78, 12, 39] }

    it 'return the most profitable pair' do
      expect(stock.stock_picker).to eq([0, 1])
    end

    it 'return the first pair if there are equally profitable' do
      stock = [47, 45, 78, 12, 39, 45]
      expect(stock.stock_picker).to eq([1, 2])
    end

    it 'return empty array if no profitable option' do
      stock = [47, 12, 11, 10, 6]
      expect(stock.stock_picker).to eq([])
    end
  end
end
