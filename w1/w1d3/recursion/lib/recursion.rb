require 'byebug'

def range(start_val, q)
  return [] if q <= start_val + 1
  arr = []
  arr << start_val + 1
  arr + range(start_val + 1, q)
end

def i_range(start_val, q)
  arr = []
  i = start_val + 1
  while i <
    arr << i
    i += 1
  end
  arr

end

def exp1(b, n)
  return 1 if n == 0

  b * exp1(b, n - 1)
end

def exp2(b, n)
  return 1 if n == 0
  return b if n == 1

  if n.even?
    base = exp2(b, n / 2)
    base * base
  else
    base = exp2(b, (n - 1) / 2)
    base * base * b
  end
end

class Array

  def deep_dup

    return self.dup if self.none? { |el| el.is_a?(Array) }

    copy = []
    self.each do |el|
      copy << el.deep_dup if el.is_a?(Array)
    end

    copy
  end

end

def fib(n)
  return [1] if n == 1
  return [1, 1] if n <= 2
  prev_num = fib(n - 1).last
  two_prev = fib(n - 2).last
  fib(n - 1) << prev_num + two_prev
end
=begin
def permutations(array)

  return [array] if array.length == 1

  result = []

  num = array.shift
  perms = permutations(array)


  perms.each do |perm|
    (0..perm.length).each do |idx|
      result << perm[0...idx] + [num] + perm[idx..-1]
    end
  end

  result

end
=end

def permutations(array)
  return array if array.length == 1
  perms = []
  array.each_index do |idx|
    # debugger
    shifted = array.rotate(idx)

    permutations(shifted[1..-1]).each do |arr|
      perms << [arr].unshift(shifted[0])
    end
  end
  perms.map(&:flatten)

end

def bsearch(array, target)
  #check to see if array is sorted
  return unless array == array.sort

  midx = array.length / 2
  return midx if target == array[midx]

  left = array[0...midx]
  right = array[midx..-1]

  return nil if left.empty? || right.empty?

  if target < array[midx]
    bsearch(left, target)
  else
    begin
      left.length + bsearch(right, target)
    rescue
      return nil
    end
  end

end

def merge_sort(arr)
  return arr if arr.length <= 1

  midx = arr.length / 2
  left, right = arr[0...midx], arr[midx..-1]

  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  res = []

  until left.empty? || right.empty?
    if left[0] <= right[0]
      res << left.shift
    else
      res << right.shift
    end
  end
  res + left + right
end

def subsets(arr)
  return [arr] if arr.empty?
  last = arr.pop

  subs = []
  subs = subs + subsets(arr) << [last]
  subs.each do |s|
    new_sub = (s.include?(last) ? s : (s + [last]))
    subs << new_sub unless subs.include?(new_sub)
  end
  subs
  # subs.each do |sub|
  #   subs << (sub + [last])
  # end
  # subs
end

def greedy_make_change(amount, bank = [25, 10, 5, 1])
  return [amount] if bank.any? { |el| el == amount }
  change = []

  bank.each do |coin|
    if coin < amount
      change += [coin] + greedy_make_change(amount - coin, bank)
    end
    break if coin < amount
  end
  change
end

# 24, [10, 7, 1]

def make_better_change(amount, bank = [25, 10, 5, 1])
  return [amount] if bank.any? {|el| el == amount }

  least_coins = 1000
  change = []
  bank = bank.select { |c| c <= amount }
  # debugger
  bank.each do |coin|
    change += [coin] + make_better_change(amount - coin, bank)
    least_coins = change.length if change.length < least_coins
  end
p least_coins
change
end

=begin
def make_better_change(amount, bank)
  least_coins = 100
  best_sol = nil

  return [amount] if bank.any? { |el| el == amount }

  change = []
  bank =

end
=end
p [1,[1,2,3,[4]]].deep_dup
