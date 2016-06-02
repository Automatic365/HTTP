require_relative 'post_request_parser'
require_relative 'word_search'
require_relative 'game'

class ResponseRedirect

  def initialize
  end

  def request_parse(request_lines)
    post_parser = PostRequestParser.new(request_lines)
    post_parser.voltron
    game_check(post_parser.parsed_request)
  end

  def start_game(game_request)
    @game.game_check(game_request)
  end


end
