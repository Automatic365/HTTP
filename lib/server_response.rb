require 'pry'

require_relative "request_parser"
require_relative "word_search"
require_relative "game"

 class ServerResponse
   attr_accessor :hello_count
  def initialize
    @hello_count = 1
  end

  def format_response(request_lines)
    parser = RequestParser.new(request_lines)
    parser.append
    @request = parser.request
    path_check
  end

  def path_check
    # if @request["Path:"]=="/hello"
    #   hello_response
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
  # 
  # def hello_response
  #   "Hello, World!("
  # end

  def date
    Time.now.strftime('%l:%M%p on %A, %B %e, %Y ')
  end

  def start_game(request)
    new_game = Game.new

  end

  def response_body_formatter
    formatted_response = @request.to_a.map{|line|"#{line.first} #{line.last}\n"}.join

    # formatted_response.unshift("<html><head></head><body><pre>\n")
    # formatted_response.push("\n</pre></body></html>")
  end


  def word_search
    searcher = WordSearch.new
    word = @request["Path:"].split("=").last
    searcher.word_validation(word)
  end

end
