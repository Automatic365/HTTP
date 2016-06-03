require_relative 'post_request_parser'
require 'pry'

class Game
  attr_reader :total_guesses
  attr_accessor :last_guess, :parsed_request, :game_on

  def initialize
    @game_on = false
    @answer = rand(1..100)
  end

  def game_check(request)
    # binding.pry
    if request.first.include?("/start_game")
      @game_on = true
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
      # evaluate_guess(last_guess)
  end

  def post_parse(request)
    post_parser = PostRequestParser.new(request)
    post_parser.voltron
    @parsed_request = post_parser.parsed_request
  end


  # def start_check
  #  if @parsed_request["Path:"]=="/start_game"
  #    start_game
  #  else
  #    guess_check
  #  end
  # end

  def start_game
    @total_guesses = 0
    "Good Luck!"
  end

  # def get_game
  #   if @total_guesses == 0
  #     "Did you start the game yet?"
  #   else
  #     evaluate_guess(last_guess)
  #   end
  # end

  # def guess_check
  #   # binding.pry
  #   if @total_guesses == nil
  #     "You have to start the game first!"
  #   else
  #     record_guess
  #     evaluate_guess(last_guess)
  #   end
  # end

  def record_guess
    @total_guesses += 1
  end

  def evaluate_guess(guess)
    # binding.pry
    if guess.to_i < @answer
      "Guess ##{@total_guesses}: #{guess.to_i} IS TOO LOW!"
    elsif guess.to_i > @answer
      "Guess ##{@total_guesses}: #{guess.to_i} IS TOO HIGH!"
    else
      "Guess ##{@total_guesses}: #{guess.to_i} IS CORRECT!"
    end
  end

end
