require 'pry'

require_relative "request_parser"
require_relative "word_search"
require_relative "game"

 class ServerResponse

  def format_response(request_lines)
    parser = RequestParser.new(request_lines)
    parser.voltron
    @request = parser.request
    path_check(request_lines)
  end


  def path_check(request_lines)
    if datetime_check(request_lines)
      date
    elsif word_search_check(request_lines)
      word_search
    else
      response_body_formatter
    end
  end

  def datetime_check(request_lines)
    request_lines.first.include?("/datetime")
  end

  def word_search_check(request_lines)
    request_lines.first.include?("/word_search")
  end

  def date
    Time.now.strftime('%l:%M%p on %A, %B %e, %Y')
  end

  def response_body_formatter
    @request.to_a.map{|line|"\n#{line.first} #{line.last}"}.join
  end

  def word_search
    searcher = WordSearch.new
    word = @request["Path:"].split("=").last
    searcher.word_validation(word)
  end

end
