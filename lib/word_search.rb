require 'pry'

class WordSearch
  attr_reader :dictionary
  def initialize
    @dictionary = File.read("/usr/share/dict/words").split("\n")
  end

end
