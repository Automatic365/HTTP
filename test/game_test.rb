require_relative '../lib/game'
require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require 'pry'

class GameTest < Minitest::Test


  def test_start_game
    skip
    conn = Faraday.new
    response = conn.get('http://127.0.0.1:9494/start_game')

    assert response.body.include?("Good Luck!")
  end

  def test_post_guess
    conn = Faraday.new
    response = conn.post('http://127.0.0.1:9494/game?guess=4',:guess => "4")

    refute response.body.include?("CORRECT!")
  end

end
