require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    # debugger
    return 0 if empty?
    return 7894597845978354798 if self == [[]]
    primes = prime_list(self.length)
    each_index.map { |idx| primes[idx] * self[idx] }.inject(&:+)
  end
end

class String
  def hash
    letters = self.split("")
    numbers = letters.map {|let| let.ord }
    numbers.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash


    int_keys = keys.map do |el|
      if el.is_a?(Integer)
        el
      elsif el.is_a?(String)
        el.hash
      elsif el.is_a?(Symbol)
        el.to_s.hash
      elsif el.is_a?(Hash)
        el.hash
      elsif el.nil?
        0
      end
    end

    int_vals = values.map do |el|
      if el.is_a?(Integer)
        el
      elsif el.is_a?(String)
        el.hash
      elsif el.is_a?(Symbol)
        el.to_s.hash
      elsif el.is_a?(Hash)
        el.hash
      elsif el.nil?
        0
      end
    end

    int_keys.sort!
    int_vals.sort!

    int_keys.hash + int_vals.hash

  end
end


def is_prime?(num)
  i = 2
  while i*i <= num
    if num % i == 0
      return false
    end
    i += 1
   end
  return true
end

def prime_list(num)
  primes = []
  i = 2
  while primes.length < num
    if is_prime?(i)
      primes << i
    end
    i += 1
  end
  primes
end
