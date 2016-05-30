require './test/testhelper'
require_relative '../lib/word_search'

class WordSearchTest < Minitest::Test

  def test_fetch_first_word
    searcher = WordSearch.new

    assert_equal "A", searcher.dictionary.first
    assert_equal "aardvark", searcher.dictionary[7]
  end

end
