require 'pry'

class WordSearch
  attr_reader :dictionary

  def initialize
    @dictionary = File.read("/usr/share/dict/words").split("\n")
  end


  def valid_word?(word)
    if word
      word = word.downcase
    end
    @dictionary.include?(word)
  end

end
