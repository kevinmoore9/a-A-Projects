require 'byebug'

# shovel values -- add arrays

def range(start_val, end_val)
  return [] if start_val + 1 == end_val
  nums = [start_val + 1]
  nums + range(start_val + 1, end_val)
end

def range2(min, max)
  return [] if max <= min
  range2(min, max - 1) << max - 1
end

def range_sum(min, max)
  return min if max == min
  max + range_sum(min, max - 1)
end

###array sum

def sum(nums)
  return 0 if nums.empty?
  sum(nums[0..-2]) + nums[-1]

end

#use drop and take
def sum2(nums)
  return 0 if nums.empty?
  nums[0] + sum2(nums.drop(1))
end

def exp1(b, p)
  return 1 if p == 0
  b * exp1(b, p - 1)
end

class Array
  def deep_dup
    result = []

    each do |el|
      result << (el.is_a?(Array) ? el.deep_dup : el.dup)
    end
    result
  end
end

def fibs(n)
  return [0,1].take(n) if n <= 2
  fib = fibs(n - 1)
  fib << fib[-2] + fib[-1]
end

# first n factorials

def n_facts(n)
  return [] if n <= 0
  return [1, 1].take(n) if n <= 2

  facts = n_facts(n - 1)
  facts << facts[-1] * (n - 1)
end

def permutations(arr)
  return [arr] if arr.length == 1
  perms = []
  first = arr[0]

  permutations(arr[1..-1]).each do |perm|
    temp = ([first] + perm)
    temp.each_index {|i| perms << temp.rotate(i)}
  end
  perms
end


def bsearch(arr, target)
  return nil if arr.empty?

  midx = arr.length / 2
  return midx if arr[midx] == target

  if target < arr[midx]
    subarr = arr[0...midx]
    return bsearch(subarr, target)
  else
    subarr = arr[midx..-1]
    return midx + bsearch(subarr, target)
  end
end

class Array
## can use take / drop
## left, right = self.take(midx), self.drop(midx)
  def merge_sort
    return self if length <= 1
    midx = length / 2

    left, right = self[0...midx], self[midx..-1]
    merge(left.merge_sort, right.merge_sort)
  end

  def merge(left, right)
    res = []

    until left.empty? || right.empty?
      if left[0] < right[0]
        res << left.shift
      else
        res << right.shift
      end
    end
    res + left + right
  end
end


def subsets(arr)
  return [[]] if arr.empty?

  last_el = arr.pop
  subs = subsets(arr)
  new_sets = subs.map { |set| set + [last_el]}
  new_sets + subs
end

# [[],[1]]  >> [[2],[1, 2]]

def make_greedy_change(amount, bank = [25,10,5,1])
  return [] if amount == 0

  bank.each_with_index do |coin, idx|
    next if coin > amount

    remainder = amount - coin
    return [coin] + make_greedy_change(remainder, bank)
  end
end


def make_change(amount, bank = [25,10,5,1])
  return [] if amount == 0
  best_change = nil

  bank.each do |coin|
    next if amount < coin

    remainder = amount - coin
    best_remainder =  make_change(remainder, bank)
    next if best_remainder.nil?

    coins = [coin] + best_remainder
    best_change = coins if (best_change.nil? ||
      (coins.length < best_change.length))
  end

  best_change
end
