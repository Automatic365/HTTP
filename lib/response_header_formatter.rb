require_relative 'server_response'
require_relative 'game'
require_relative 'response_redirect'
require 'pry'

class ResponseHeaderFormatter
  attr_accessor :formatted_response, :game
  def initialize
    @server_response = ServerResponse.new
    @total_count = 0
    @hello_count = 0
    @game = Game.new
  end


  def form_response(request)
    @request = request
    @total_count += 1
    # binding.pry
    if @request.first.include?("game")
      game_start
    elsif @request.any?{|line|line.include?("/shutdown")}
      shutdown_format
    elsif @request.first.include?("/hello")
      hello_format
    else
      @formatted_response = @server_response.format_response(@request)
    end
  end

  def shutdown_format
    @formatted_response = "Total Requests:(#{@total_count})"
  end

  def hello_format
    @formatted_response = "Hello, World!(#{@hello_count+=1})"
  end


  def format_output
    "<html><head></head><body>#{@formatted_response}</body></html>"
  end

  def format_headers
    # binding.pry
    if @request.first.split[1] == "/game" && @request.first.split.first == "POST"
      response_redirect
    else
    ["http/1.1 200 ok",
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     "server: ruby",
     "content-type: text/html; charset=iso-8859-1",
     "content-length: #{format_output.length}\r\n\r\n"].join("\r\n")
   end
  end

  def game_start
    @formatted_response = @game.game_check(@request)
  end

  def response_redirect
    redirect_formatter = ResponseRedirect.new
    redirect_formatter.create_redirect(@game.parsed_request)
    redirect_formatter.redirect_headers
    # binding.pry
  end


  def post_check(request_lines)
    guess_check(request_lines) if request_lines.first.include?("POST")
  end

  def guess_check(request_lines)
    request_lines.first.split[1] == "/game"
  end

end
