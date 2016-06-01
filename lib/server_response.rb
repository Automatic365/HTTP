require 'pry'

require_relative "request_parser"
require_relative "word_search"

 class ServerResponse
   attr_reader :hello_count
  def initialize
    @hello_count = 0
    @total_count = 0
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
    # elsif @request["Path:"]=="/shutdown"
    #   shutdown
    elsif @request["Path:"].include?("/word_search")
      word_search
    else
      response_body_formatter
    end
  end

  def hello_response
    (@hello_count+=1)
    "Hello, World!(#{@hello_count})"
  end

  def date
    Time.now.strftime('%l:%M%p on %A, %B %e, %Y ')
  end


  def response_body_formatter
    formatted_response = Array.new
    @request.each do |header, value|
      formatted_response << "#{header} #{value}"
    end
    formatted_response.unshift("<html><head></head><body><pre>\n")
    formatted_response.push("\n</pre></body></html>")
  end


  def word_search
    searcher = WordSearch.new
    word = @request["Path:"].split("=").last
    searcher.word_validation(word)
  end
  #
  # if response == "Hello, World"
  #      hello_counter += 1
  #    end

end
