def first_anagram?(str1,str2)
  anagrams = str1.split("").permutation.to_a
  anagrams.include?(str2.split(""))
end

# p first_anagram?("abc","bca")
# p first_anagram?("abc","lde")
# p first_anagram?("abc","abcd")

def second_anagram?(str1,str2)
  copies = ""
  str1.each_char.with_index do |char1,idx1|
    str2.each_char.with_index do |char2, idx2|
      if char2 == char1
        copies += char1
      end
    end
  end
  copies.length == str1.length && str1.length == str2.length
end

# p second_anagram?("abc","bca")
# p second_anagram?("abc","lde")
# p second_anagram?("abc","abcd")


def third_anagram?(str1,str2)
  str1.split("").sort == str2.split("").sort
end

# p third_anagram?("abc","bca")
# p third_anagram?("abc","lde")
# p third_anagram?("abc","abcd")


def fourth_anagram?(str1,str2)
  str_hash = Hash.new(0)
  str1.each_char do |char|
    str_hash[char] += 1
  end

  str2.each_char do |char|
    str_hash[char] -= 1
  end

  str_hash.values.all? { |num| num == 0}
end

p fourth_anagram?("abc","bca")
p fourth_anagram?("abc","lde")
p fourth_anagram?("abc","abcd")
