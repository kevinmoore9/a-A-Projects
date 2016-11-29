def brute_two_sum(arr,target_sum)
  arr.each_with_index do |el, i|
    j = 1
    while i + j < arr.size
      return true if arr[i] + arr[i + j] == target_sum
      j += 1
    end
  end
  false
end

arr = [0, 1, 5, 7]
p brute_two_sum(arr,6)


def okay_two_sum?(arr, target)
  arr.sort!
  arr.each_with_index do |el, idx|
    array = arr.dup
    array.delete_at(idx)
    return true if array.bsearch {|x| x == target - el }

  end
  false
end

arr = [0, 1, 5, 7]
p okay_two_sum?(arr,10)


def best_two_sum?(arr, target)
  hash = {}

  arr.each do |el|
    return true if hash[target - el]
    hash[el] = true
  end
  false
end

arr = [0, 1, 5, 7]
p best_two_sum?(arr,10)
p best_two_sum?(arr,6)
