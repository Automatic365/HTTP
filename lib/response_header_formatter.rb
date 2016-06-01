require_relative 'server_response'
require 'pry'

class ResponseHeaderFormatter
  attr_accessor :formatted_response, :total_count, :hello_count
  def initialize
    @server_response = ServerResponse.new
    @total_count = 0
    @hello_count = 0
  end


  def form_response(request_lines)
    @total_count +=1
    if request_lines.any?{|line|line.include?("/shutdown")}
      @formatted_response = "<pre>Total Requests:(#{@total_count})</pre> "
    elsif request_lines.first.include?("/hello")
      @formatted_response = "<pre>Hello, World!(#{@hello_count+=1})</pre>"
    else
      @formatted_response = @server_response.format_response(request_lines)
    end
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
