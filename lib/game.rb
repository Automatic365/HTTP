require_relative 'post_request_parser'
require 'pry'

class Game
  attr_reader :total_guesses
  attr_accessor :last_guess, :parsed_request

  def initialize
    @answer = rand(1..100)
  end

  def game_check(request)
    if request.first.include?("/start_game")
      start_game
    else
      post_check(request)
      evaluate_guess(last_guess)
    end
  end


  def post_check(request)
    if request.first.split.first == "POST"
      post_parse(request)
      record_guess
    end
  end

  def post_parse(request)
    post_parser = PostRequestParser.new(request)
    post_parser.voltron
    @parsed_request = post_parser.parsed_request
  end


  def start_game
    @total_guesses = 0
    "Good Luck!"
  end

  def record_guess
    @total_guesses += 1
  end

  def evaluate_guess(guess)
    if guess.to_i < @answer
      "Guess ##{@total_guesses}: #{guess.to_i} IS TOO LOW!"
    elsif guess.to_i > @answer
      "Guess ##{@total_guesses}: #{guess.to_i} IS TOO HIGH!"
    else
      "Guess ##{@total_guesses}: #{guess.to_i} IS CORRECT!"
    end
  end

end
