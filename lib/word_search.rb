class WordSearch

  def initialize
    @dictionary = File.read("/usr/share/dict/words").split("\n")
  end


  def valid_word?(word)
    word = word.downcase if word
    @dictionary.include?(word)
  end

  def word_validation(word)
    if valid_word?(word)
      "<pre>#{word} is a word.</pre>"
    else
      "<pre>#{word} is not a word.</pre>"
    end
  end

end
