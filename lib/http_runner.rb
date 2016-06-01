require_relative 'server_response'
require_relative 'response_header_formatter'
require 'socket'
require 'pry'
class HTTPRunner

  def initialize
    @total_count = 0
    @tcp_server = TCPServer.new(9494)
    @hello_count = 0
    @response_formatter = ResponseHeaderFormatter.new
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
    @response_formatter.form_response(request_lines)
    format_response_headers(request_lines)
  end



  def format_response_headers(request_lines)
    @response = @response_formatter.formatted_response
    @output = @response_formatter.format_output
    @headers = @response_formatter.format_headers
    client_response
  end



  def client_response
    @client.puts @headers
    @client.puts @output
    shutdown
  end

  def shutdown
    if @response.include?("Requests")
      @client.close
    else
      reconnect
    end
  end

  def reconnect
    @client.close
    connect
  end
end

runner = HTTPRunner.new
runner.connect
