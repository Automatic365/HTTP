require_relative 'server_response'

class Game
  attr_reader :total_guesses, :game_on

  def initialize
    @total_guesses = 0
    @game_on = false
  end



end
