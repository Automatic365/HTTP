require_relative 'server_response'
require 'socket'
require 'pry'
class HTTPRunner

  def initialize
    @total_count = 0
    @tcp_server = TCPServer.new(9494)
    @server_response = ServerResponse.new
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
    shutdown_check(request_lines)
  end

  def shutdown_check(request)
    if request.any?{|line|line.include?("/shutdown")}
      shutdown
    else
      conjure_response(request)
    end
  end

  def shutdown
    response = "Total Requests: #{@total_count}"
    @client.puts response
    @client.close
  end

  def conjure_response(request)
    response = @server_response.format_response(request)
    sort_response(response)
  end

  def sort_response(response)
    if response.class == String
      hello_check(response)
      @client.puts response
      server_close
    else
      response_body(response)
    end
  end

  def hello_check(response)
    if response.include?("Hello")
      @server_response.hello_count += 1
    end
  end

  def response_body(response)
    response.each{|line| @client.puts line}
    server_close
  end

  def server_close
    @client.close
    connect
  end
end

runner = HTTPRunner.new
runner.connect
