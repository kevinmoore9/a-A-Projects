


class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store << el
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

end

class MyStack
  attr_reader :min, :max
  def initialize
    @store = []
    @max = []
    @min = []
  end

  def pop
    @max.pop
    @min.pop
    @store.pop
  end

  def push(el)
    if empty?
      @max << el
      @min << el
    else
      @max << (el > @max.last ? el : @max.last)
      @min << (el < @min.last ? el : @min.last)
    end
    @store << el
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end


end

class StackQueue
  def initialize(window_size)
    @left = MyStack.new
    @right = MyStack.new
    @window = window_size
  end

  def enqueue(el)
    if @left.size == @window
      @window.times do
        @right.push(@left.pop)
      end
    end
    @left.push(el)
  end

  def dequeue
    @right.pop
  end

  def size
    @left.size + @right.size
  end

  def empty?
    @right.empty? && @left.empty?
  end

  def max
    if @left.max.empty?
      @right.max.last
    elsif @right.max.empty?
      @left.max.last
    else
      @right.max.last > @left.max.last ? @right.max.last : @left.max.last
    end
  end

  def min
    if @left.min.empty?
      @right.min.last
    elsif @right.min.empty?
      @left.min.last
    else
      @right.min.last < @left.min.last ? @right.min.last : @left.min.last
    end
  end
end


def naive_max_range(arr, w)
  current_max_range = nil
  arr.each_cons(w) do |window|
    if current_max_range == nil || (window.max - window.min) > current_max_range
      current_max_range = window.max - window.min
    end
  end
  current_max_range
end

# arr = [0, 1, 5, 7]
# p naive_max_range(arr,3)


def windowed_max_range(arr,w)
  max_range = 0
  sq = StackQueue.new(w)
  arr.each do |el|
    sq.enqueue(el)
    sq.dequeue #possible bug
    max_range = (sq.max - sq.min) if (sq.max - sq.min) > max_range
  end
  max_range
end

beginning_time = Time.now
1.times do
  windowed_max_range([1, 0, 2, 5, 4, 8]* 100, 300) == 4 # 4, 8

end
end_time = Time.now
puts "Efficint Case: Time elapsed #{(end_time - beginning_time)*100} milliseconds"

beginning_time = Time.now
1.times do
  naive_max_range([1, 0, 2, 5, 4, 8]* 100, 300) == 4 # 4, 8

end
end_time = Time.now
puts "Bad Case: Time elapsed #{(end_time - beginning_time)*100} milliseconds"
