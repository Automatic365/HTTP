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

  def test_post_compares_guess_to_answer
    conn = Faraday.new
    header = conn.post('http://127.0.0.1:9494/start_game')
    response = conn.post('http://127.0.0.1:9494/game',:guess => "342")

    assert response.body.include?("TOO HIGH!")
  end

  def test_post_guess_causes_redirect

    conn = Faraday.new
    header = conn.post('http://127.0.0.1:9494/start_game')
    response = conn.post('http://127.0.0.1:9494/game',:guess => "4")

    assert_equal 302, response.status
  end

  def test_game_only_returns_last_guess

     conn = Faraday.new

     header = conn.post('http://127.0.0.1:9494/start_game')
     conn.post('http://127.0.0.1:9494/game',:guess => 24)
     conn.post('http://127.0.0.1:9494/game',:guess => 42)
     response = conn.post('http://127.0.0.1:9494/game',:guess => 14)


     assert response.body.include?("14")
  end
  def test_game_returns_number_of_guesses
    conn = Faraday.new

    header = conn.post('http://127.0.0.1:9494/start_game')
    conn.post('http://127.0.0.1:9494/game',:guess => 12)
    conn.post('http://127.0.0.1:9494/game',:guess => 54)
    conn.post('http://127.0.0.1:9494/game',:guess => 5)
    conn.post('http://127.0.0.1:9494/game',:guess => 78)
    response = conn.post('http://127.0.0.1:9494/game',:guess => 23)

    assert response.body.include?("Guess #5")
  end
end
