require_relative 'server_response'
require_relative 'response_header_formatter'
require 'socket'
require 'pry'
class HTTPRunner

  def initialize
    @total_count = 0
    @tcp_server = TCPServer.new(9494)
    @server = ServerResponse.new

  end

  def connect
    @client = @tcp_server.accept
    incoming_request
  end

  def incoming_request
    request_lines = []
    (@total_count += 1)
    while line = @client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    format_response_headers(request_lines)
  end



  def format_response_headers(request_lines)
    if request_lines.any?{|line|line.include?("/shutdown")}
      shutdown
    else
      @response_formatter = ResponseHeaderFormatter.new(request_lines)
      @response = @response_formatter.form_response
      @output = @response_formatter.format_output
      @headers = @response_formatter.format_headers
    end
    hello_check
    client_response
  end

  def hello_check
    @server.hello_count += 1 if @response.include?("Hello")
  end


  def shutdown
    @format_response_headers.formatted_response = "Total Requests: #{@total_count}"
    @response = @format_response_headers.formatted_response
    @client.puts @headers
    @client.puts @output
    @client.close
  end

  def client_response
    @client.puts @headers
    @client.puts @output
    server_close
  end

  def server_close
    @client.close
    connect
  end
end

runner = HTTPRunner.new
runner.connect
