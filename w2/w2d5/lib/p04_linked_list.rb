require 'byebug'


class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList
  include Enumerable
  
  def initialize
    @first = Link.new
    @last = Link.new
    @first.next = @last
    @last.prev = @first
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @first
  end

  def last
    @last
  end

  def empty?
    return true if @first.key.nil? && @last.key.nil?
    false
  end

  def get(key)
    each do |node|
      if node.key == key
        return node.val
      end
    end
    nil
  end

  def include?(key)
    each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    if @first.key.nil?
      @first = new_link
      @first.next = @last
      @last.prev = @first
    elsif @last.key.nil?
      @last = new_link
      @last.prev = @first
      @first.next = @last
    else
      new_link.prev = @last
      @last.next = new_link
      @last = new_link
    end
  end

  def update(key, val)
    each do |node|
      if node.key == key
        node.val = val
      end
    end
    nil
  end

  def remove(key)
    each do |node|
      if node.key == key
        if node == @first
          node.next.prev = nil
          @first = node.next
        elsif node == @last
          node.prev.next = nil
          @last = node.prev
        else
          node.next.prev = node.prev
          node.prev.next = node.next
        end
        node.prev, node.next = nil, nil
      end
    end
  end

  def each(&prc)
    current_node = @first
    until current_node == nil
      prc.call(current_node)
      current_node = current_node.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
