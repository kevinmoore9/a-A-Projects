# time complexity: n^2

#def my_min(arr)
#   arr.each do |el|
#     return el if arr.all? { |el2| el <= el2 }
#   end
#   nil
# end


 #time complexity: n
def my_min(arr)
  min = arr.first

  arr.each do |el|
    min = el if el < min
  end
  min
end

# def largest_contiguous_sub_sum(arr)
#   sub_arrays = []
#
#   arr.each_index do |i|
#     j = 0
#     while i + j < arr.length
#       sub_arrays << arr[i..(i+j)]
#       j += 1
#     end
#   end
#   sub_arrays.map {|el| el.inject(&:+) }.max
# end

def largest_contiguous_sub_sum(arr)
  largest_sum = arr.first
  tally = 0
  arr[1..-1].each do |el|

    test_sum = [el, el + largest_sum + tally].max
    if test_sum > largest_sum
      largest_sum = test_sum
      tally = 0
    else
      tally += el
    end
  end
  largest_sum
end


p largest_contiguous_sub_sum([2,-10,3,4,-1,2,-3])

largest_sum = 2 2 4
current_sum = 2 1 4
tally =       0
