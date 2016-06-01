require_relative 'server_response'
require 'pry'

class Game
  attr_reader :total_guesses, :game_on

  def initialize
    @total_guesses = 0
    @game_on = false
    @answer = rand(1..100)
  end

  def game_check(request)
    @request = request
    if @request["Path:"]=="/start_game"
      start_game
    elsif @request["Path:"].include?("/game")
      verb_check
    end
  end

  def start_game
    "Good Luck!"
  end

  def verb_check
    if @request["Verb:"]=="POST"
      record_guess
      get_guess
    elsif @request["Verb:"] == "GET"
      get_game
    end
  end

  def get_game

  end

  def record_guess
    @total_guesses += 1
  end

  def get_guess
    last_guess = @request["Path:"].split("=").last
    evaluate_guess(last_guess)
  end

  def evaluate_guess(guess)
    if guess.to_i < @answer
      "TOO LOW!"
    elsif guess.to_i > @answer
      "TOO HIGH!"
    else
      "CORRECT!"
    end
  end

  def post_game

  end

end
