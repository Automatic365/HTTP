require 'pry'

require_relative "request_parser"
require_relative "word_search"

 class ServerResponse
  def initialize
    @count = -1
  end

  def format_response(request_lines)
    @parser = RequestParser.new(request_lines)
    @request = @parser.request
    @parser.append
    path_check
  end

  def path_check
    if @request["Path:"]=="/hello"
      hello_response
    elsif @request["Path:"]=="/datetime"
      date
    elsif @request["Path:"].include?("/word_search")
      word_search
    else
      response_body_formatter
    end
  end

  def hello_response
    @count += 1
    "Hello, World!(#{@count})".split
  end

  def date
    Time.now.strftime('%l:%M%p on %A, %B %e, %Y ').split
  end

  def shutdown
    "Total Requests: #{count}"
    close(client)
  end

  def response_body_formatter
    formatted_response = Array.new
    @request.each do |header, value|
      formatted_response << "#{header} #{value}"
    end
    formatted_response
  end

  def close(client)
    client.close
  end

  def word_search
    searcher = WordSearch.new
    word = @request["Path:"].split("=").last
    searcher.word_validation(word).split
  end



end
