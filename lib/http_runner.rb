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

    @response = "Total Requests: #{@total_count}"
    init_output
    @client.puts @headers
    @client.puts @output
    @client.close
  end

  def conjure_response(request)
    @response = @server_response.format_response(request)
    init_output
    sort_response
  end

  def init_output
    @output = "<html><head></head><body>#{@response}</body></html>"
    init_headers
  end

  def init_headers
    @headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-lenth: #{@output.length}\r\n\r\n"].join("\r\n")
  end

  def sort_response
    if @response.class == String
      hello_check
      @client.puts @headers
      @client.puts @output
      server_close
    else
      response_body
    end
  end

  def hello_check
    @server_response.hello_count += 1 if @response.include?("Hello")
  end

  def response_body
    @client.puts @headers
    # response.each{|line| @client.puts line}
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
