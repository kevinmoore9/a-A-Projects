class Array

  def my_uniq
    result = []

    each do |el|
      result << el unless result.include?(el)
    end
    result
  end

  def two_sum
    result = []

    each_with_index do |el, idx|
      j = idx + 1
      while j < length
        result << [idx, j] if el + self[j] == 0
        j += 1
      end
    end
    result
  end

  def my_transpose
    trans = Array.new(length) { Array.new(length) }

    each_index do |i|
      self[i].each_index do |j|
        trans[i][j] = self[j][i]
      end
    end
    trans
  end

  def stock_picker
    best_pair = []
    biggest_profit = 0

    each_index do |i|
      j = i + 1
      while j < length
        if biggest_profit < (self[j] - self[i])
          best_pair = [i, j]
          biggest_profit = self[j] - self[i]
        end
        j += 1
      end
    end
    best_pair
  end
end
