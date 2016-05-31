require_relative 'server_response'
require 'socket'
require 'pry'
class HTTPRunner

  def connect
    tcp_server = TCPServer.new(9494)
    @client = tcp_server.accept
    incoming_request
  end

  def incoming_request
    request_lines = []
    while line = @client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    conjure_response(request_lines)
  end

  def conjure_response(request)
    server_response = ServerResponse.new
    response = server_response.format_response(request)
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
