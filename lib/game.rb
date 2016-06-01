require_relative 'server_response'

class Game
  attr_reader :total_guesses, :game_on

  def initialize(request)
    @request = request
    @total_guesses = 0
    @game_on = false
  end

  def game_check
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
      post_game
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
    
  end

end
