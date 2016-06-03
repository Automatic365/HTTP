require_relative 'testhelper'
require_relative '../lib/word_search'

class WordSearchTest < Minitest::Test

  def test_if_valid_word
    searcher = WordSearch.new

    assert searcher.valid_word?("aardvark")
  end

  def test_if_invalid_word
    searcher = WordSearch.new

    refute searcher.valid_word?("pardvark")
  end

  def test_wacky_case
    searcher = WordSearch.new

    assert searcher.valid_word?("haMsTer")
    assert searcher.valid_word?("cHaRISMa")
  end

end
