require_relative '../lib/game'
require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require 'pry'

class GameTest < Minitest::Test


  def test_start_game
    conn = Faraday.new
    response = conn.post('http://127.0.0.1:9494/start_game')

    assert response.body.include?("Good Luck!")
  end

  def test_post_guess_returns_guess
    conn = Faraday.new
    header = conn.post('http://127.0.0.1:9494/start_game')
    response = conn.post('http://127.0.0.1:9494/game',:guess => "24")

    assert response.body.include?("24")
  end
  
  def test_post_guess_causes_redirect

    conn = Faraday.new
    header = conn.post('http://127.0.0.1:9494/start_game')
    response = conn.post('http://127.0.0.1:9494/game',:guess => "4")
    # binding.pry

    assert_equal 302, response.status
  end

  def test_game_wont_allow_posting_without_guess

     conn = Faraday.new

     header = conn.post('http://127.0.0.1:9494/start_game')
     conn.post('http://127.0.0.1:9494/game',:guess => 24)
     conn.post('http://127.0.0.1:9494/game',:guess => 42)
     response = conn.post('http://127.0.0.1:9494/game',:guess => 14)


     assert response.body.include?("Guess #3")
     assert response.body.include?("14")
  end

end
