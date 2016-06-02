require 'pry'

require_relative "request_parser"
require_relative "post_request_parser"
require_relative "word_search"
require_relative "game"

 class ServerResponse

  def format_response(request_lines)
    parser = RequestParser.new(request_lines)
    parser.voltron
    @request = parser.request
    path_check
  end


  def path_check
    if @request["Path:"]=="/datetime"
      date
    elsif @request["Path:"].include?("/word_search")
      word_search
    else
      response_body_formatter
    end
  end

  def date
    Time.now.strftime('%l:%M%p on %A, %B %e, %Y ')
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
