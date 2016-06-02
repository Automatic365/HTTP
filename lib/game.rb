require_relative 'post_request_parser'
require 'pry'

class Game
  attr_reader :total_guesses
  attr_accessor :last_guess

  def initialize
    @game_on = false
    @answer = rand(1..100)
  end

  def game_check(request)
    post_parser = PostRequestParser.new(request)
    if request.first.include?("POST")
      post_parser.voltron
      @request = post_parser.parsed_request
      start_check
    else
      get_game
    end
  end


  def start_check
   if @request["Path:"]=="/start_game"
     start_game
   else
     guess_check
   end
  end

  def start_game
    @total_guesses = 0
    "Good Luck!"
  end

  def get_game
    if last_guess == nil
      "Did you start the game yet?"
    else
      evaluate_guess(last_guess)
    end
  end

  def guess_check
    # binding.pry
    if @total_guesses == nil
      "You have to start the game first!"
    else
      record_guess
      evaluate_guess(last_guess)
    end
  end

  def record_guess
    @total_guesses += 1
  end

  def evaluate_guess(guess)
    # binding.pry
    if guess.to_i < @answer
      "#{guess.to_i} IS TOO LOW!"
    elsif guess.to_i > @answer
      "#{guess.to_i} IS TOO HIGH!"
    else
      "#{guess.to_i} IS CORRECT!"
    end
  end

end
