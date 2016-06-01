require_relative 'server_response'
require 'pry'

class ResponseHeaderFormatter
  attr_accessor :formatted_response, :formatted_output, :formatted_headers
  def initialize(request_lines)
    @request_lines = request_lines
    @server_response = ServerResponse.new
  end


  def form_response
    @server_response.format_response(@request_lines)
  end



  def format_output
    @formatted_output = "<html><head></head><body>#{form_response}</body></html>"
  end

  def format_headers
    @formatted_headers = ["http/1.1 200 ok",
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     "server: ruby",
     "content-type: text/html; charset=iso-8859-1",
     "content-lenth: #{format_output.length}\r\n\r\n"].join("\r\n")
  end

end
