require_relative 'server_response'
require_relative 'game'
require_relative 'response_redirect'
require 'pry'

class ResponseHeaderFormatter
  attr_accessor :formatted_response
  def initialize
    @server_response = ServerResponse.new
    @response_redirect = ResponseRedirect.new
    @total_count = 0
    @hello_count = 0
    @game = Game.new
  end


  def form_response(request)
    @total_count += 1
    if request.any?{|line|line.include?("/shutdown")}
      shutdown_format
    elsif request.first.include?("/hello")
      hello_format
    elsif request.first.include?("game")
      @formatted_response = "<pre>#{@game.game_check(request)}</pre>"
    else
      @formatted_response = @server_response.format_response(request)
    end
  end

  def shutdown_format
    @formatted_response = "<pre>Total Requests:(#{@total_count})</pre>"
  end

  def hello_format
    @formatted_response = "<pre>Hello, World!(#{@hello_count+=1})</pre>"
  end


  def format_output
    "<html><head></head><body>#{@formatted_response}</body></html>"
  end

  def format_headers
    ["http/1.1 200 ok",
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     "server: ruby",
     "content-type: text/html; charset=iso-8859-1",
     "content-lenth: #{format_output.length}\r\n\r\n"].join("\r\n")
  end

end
