require 'pry'

require_relative "request_parser"
require_relative "word_search"
require_relative "game"

 class ServerResponse
  def initialize
    @new_game = Game.new
  end

  def format_response(request_lines)
    parser = RequestParser.new(request_lines)
    binding.pry
    if request_lines.first.include?("POST")
      post_parse(request_lines)
    else
      parser.append
      @request = parser.request
      path_check
    end
  end

  def post_parse(request_lines)
    PostRequestParser.new(request_lines)
  end

  def path_check
    if @request["Path:"]=="/datetime"
      date
    elsif @request["Path:"].include?("game")
      start_game(@request)
    elsif @request["Path:"].include?("/word_search")
      word_search
    else
      response_body_formatter
    end
  end

  def date
    Time.now.strftime('%l:%M%p on %A, %B %e, %Y ')
  end

  def start_game(request)
    @new_game.game_check(request)
  end

  def response_body_formatter
    @request.to_a.map{|line|"#{line.first} #{line.last}\n"}.join
  end


  def word_search
    searcher = WordSearch.new
    word = @request["Path:"].split("=").last
    searcher.word_validation(word)
  end

end
