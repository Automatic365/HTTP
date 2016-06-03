require_relative '../lib/game'
require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require 'pry'

class GameTest < Minitest::Test


  def test_start_game
    skip
    conn = Faraday.new
    response = conn.post('http://127.0.0.1:9494/start_game')

    assert response.body.include?("Good Luck!")
  end

  def test_post_guess

    conn = Faraday.new
    header = conn.post('http://127.0.0.1:9494/start_game')
    response = conn.post('http://127.0.0.1:9494/game',:guess => "4")
    binding.pry
    assert response.body.include?("4")
  end

  def test_game_wont_allow_posting_without_guess
    skip
     conn = Faraday.new

     response = conn.get('http://127.0.0.1:9494/game')

     assert response.body.include?("Did you start the game yet?")
  end

end
