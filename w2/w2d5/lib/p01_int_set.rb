require 'byebug'

class MaxIntSet
attr_reader :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(max + 1) {false}
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true
    end
  end

  def remove(num)
    if is_valid?(num)
      @store[num] = false
    end
  end

  def include?(num)
    if is_valid?(num)
      return @store[num]
    end
  end

  private

  def is_valid?(num)
    if num < max && num >= 0
      return true
    else
      raise ArgumentError.new("Out of bounds")
    end
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count += 1
    if @count > num_buckets
      resize!
    end
    self[num] << num unless include?(num)
  end

  def remove(num)
    @count -= 1
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # debugger
    old = @store
    @count = 1
    @store = Array.new(num_buckets * 2) {Array.new}
    old.each do |bucket|
      bucket.each { |el| insert(el) }
    end
  end
end
