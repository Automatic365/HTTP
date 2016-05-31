require_relative 'server_response'
require 'socket'
require 'pry'
class HTTPRunner
  attr_reader :hello_count, :total_count, :tcp_server

  def initialize
    # @hello_count = 0
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
      # binding.pry
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

    server_respond(response)
  end

  def server_respond(response)
    response.each do |line|
      if line == response.first
        @client.puts "<html><head></head><body><pre>\n#{line}"
      elsif line == response.last
        @client.puts "#{line}\n</pre></body></html>"
      else
        @client.puts "#{line}"
      end
    end
    @client.close
    connect
  end
end

runner = HTTPRunner.new
runner.connect
