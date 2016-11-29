class Hanoi
  attr_reader :height, :towers

  def initialize(height)
    @height = height
    @towers = Array.new(3) { [] }
    @towers[0] = set_tower

  end

  def move(start_pos, end_pos)
    raise ArgumentError if towers[start_pos].empty?
    if towers[end_pos].empty? || towers[start_pos].last < towers[end_pos].last
      towers[end_pos] << towers[start_pos].pop
    else
      raise ArgumentError
    end
  end

  def won?
    @towers[1..-1].each do |tower|
      return true if tower.length == height
    end
    false
  end

  def play
    until won?
      start_pos, end_pos = get_input
      move(start_pos, end_pos)
    end
    puts "You won"
  end

  private

  def set_tower
    tower = []
    height.times do |i|
      tower.unshift(i)
    end
    tower
  end

  def get_input
    puts "Select disc from tower?"
    start_pos = gets.chomp.to_i
    puts "Select disc to move to?"
    end_pos = gets.chomp.to_i
    [start_pos, end_pos]
  end
end
# 
# g = Hanoi.new(3)
# g.play
