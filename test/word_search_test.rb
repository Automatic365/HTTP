require './test/testhelper'
require_relative '../lib/word_search'

class WordSearchTest < Minitest::Test

  def test_fetch_first_word
    searcher = WordSearch.new

    assert_equal "A", searcher.dictionary.first
    assert_equal "aardvark", searcher.dictionary[7]
  end

  def test_if_valid_word
    searcher = WordSearch.new

    assert searcher.valid_word?("aardvark")
    refute searcher.valid_word?("pardvark")
  end

  def test_wacky_case
    searcher = WordSearch.new

    assert searcher.valid_word?("haMsTer")
    assert searcher.valid_word?("cHaRISMa")
  end

end
