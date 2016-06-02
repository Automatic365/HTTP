require_relative 'server_response'
require_relative 'response_header_formatter'
require 'socket'
require 'pry'

class HTTPRunner

  def initialize
    @tcp_server = TCPServer.new(9494)
    @response_formatter = ResponseHeaderFormatter.new
  end

  def connect
    @client = @tcp_server.accept
    incoming_request
  end

  def incoming_request
    request_lines = []
    while line = @client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    parameter_check(request_lines)
    sort_response(request_lines)
  end

  def parameter_check(request_lines)
    grab_guess(request_lines) if @response_formatter.post_check(request_lines)
  end

  def grab_guess(request_lines)
    @response_formatter.game.last_guess = @client.read(request_lines.last.split(": ").last.to_i).split("=").last
  end

  def sort_response(request_lines)
    @response_formatter.form_response(request_lines)
    format_response_headers(request_lines)
  end

  def format_response_headers(request_lines)
    @response = "<pre>" + @response_formatter.formatted_response + "\n" + "</pre>"
    @output = @response_formatter.format_output
    @headers = @response_formatter.format_headers
    # binding.pry
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
