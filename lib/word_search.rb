require 'pry'

class WordSearch
  attr_reader :dictionary

  def initialize
    @dictionary = File.read("/usr/share/dict/words").split("\n")
  end


  def valid_word?(word)
    word = word.downcase if word
    @dictionary.include?(word)
  end

  def word_validation(word)
    if valid_word?(word)
      "#{word} is a word."
    else
      "#{word} is not a word."
    end
  end

end
