require 'set'

class WordChainer

  attr_reader :dictionary, :current_words

  def initialize(dictionary_file_name)
    words = File.new(dictionary_file_name).readlines.map(&:chomp)
    @dictionary = Set.new(words)
  end

  def adjacent_words(word)
    candidate_words = dictionary.select { |w| w.length == word.length }
    candidate_words.select { |c| adjacent_word(word, c) }
  end

  def adjacent_word(word1, word2)
    same = 0
    word1.length.times do |idx|
      same += 1 if word1[idx] == word2[idx]
    end
    same + 1 == word1.length
  end

  def run(s, target)
    @current_words = [s]
    @all_seen_words = { s => nil }
    until @all_seen_words.keys.include?(target) || @current_words.empty?
      new_current_words = []
      explore_current_words(new_current_words)
      @current_words = new_current_words
    end

    build_path(s, target)
  end

  def explore_current_words(new_current_words)
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adj_word|
        next if @all_seen_words.include?(adj_word)
        new_current_words << adj_word
        @all_seen_words[adj_word] = current_word
      end
    end
    new_current_words.each do |word|
      # p "word: #{word},  #{@all_seen_words[word]}"
    end
  end

  def build_path(s, target)
    path = [target]
    # p path.first
    # p @all_seen_words[path.first]
    until path.first == s
      path.unshift(@all_seen_words[path.first])
    end
    p path
  end

end

if __FILE__ == $0
  chain = WordChainer.new("dictionary.txt")
  chain.run("cat", "hat")
end
