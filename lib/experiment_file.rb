require 'socket'
require 'pry'

attr_accessor :request_lines

    tcp_server = TCPServer.new(9292)
    # binding.pry
    counter = 1
loop do
    client = tcp_server.accept
    puts "Ready for a request"
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    binding.pry


    puts "Got this request:"
    puts request_lines.inspect

    puts "Sending response."
    response = "\nVerb: POST\nPath: /\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\n"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               "server: ruby",
               "content-type: text/html; charset=iso-8859-1",
               "content-lenth: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output



    puts ["Wrote this response:", headers, output].join("\n")
    # counter += 1
    binding.pry
    client.close
end
    puts "\nResponse complete, exiting."
