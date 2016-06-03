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
    if game_path_check
      game_start
    elsif shutdown_check
      shutdown_format
    elsif hello_check
      hello_format
    else
      general_path_format
    end
  end


  def game_path_check
    @request.first.include?("game")
  end

  def shutdown_check
    @request.any?{|line|line.include?("/shutdown")}
  end

  def hello_check
    @request.first.include?("/hello")
  end

  def game_start
    @formatted_response = @game.game_check(@request)
  end

  def shutdown_format
    @formatted_response = "Total Requests:(#{@total_count})"
  end

  def hello_format
    @formatted_response = "Hello, World!(#{@hello_count+=1})"
  end

  def general_path_format
    @formatted_response = @server_response.format_response(@request)
  end

  def format_output
    "<html><head></head><body>#{@formatted_response}</body></html>"
  end

  def format_headers
    if @request.first.split[1] == "/game" && @request.first.split.first == "POST"
      ["http/1.1 302 Moved Permanently",
       "Location: http://127.0.0.1:9494/game",
       "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
       "server: ruby",
       "content-type: text/html; charset=iso=8859-1",
       "content-length: #{format_output.length}\r\n\r\n"].join("\r\n")
    else
    ["http/1.1 200 ok",
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     "server: ruby",
     "content-type: text/html; charset=iso-8859-1",
     "content-length: #{format_output.length}\r\n\r\n"].join("\r\n")
   end
  end

  def post_check(request_lines)
    guess_check(request_lines) if request_lines.first.include?("POST")
  end

  def guess_check(request_lines)
    request_lines.first.split[1] == "/game"
  end

end
