require 'socket' #provides TCP server and TCP socket classes

# initialize a TCP server object that will listen on localhost 9292 for incoming connections

tcp_server = TCPServer.new(9292)

# loop infinitely, processing one incoming connection at a time
@counter = 0
loop do
  @counter += 1

  p @counter
 # wait until a client connects, then return a TCPSocket
 # that can be used in a similar fashion to other Ruby I/O objects
 # (TCP is a subclass of IO)

 socket = tcp_server.accept
 p @counter

 # read the first lne of the request (The Request Line)

 request  = socket.gets
 p @counter

 # log the request to the console for debugging

 STDERR.puts request

 response = "Hello World:#{@counter}\n"

 # we need to inclide the content-tpe and content-lentgh headers
 # to let the client know the size and type of data
 # contained in the response. Note, HTTP is whitespace sensitive, and
 # expects each header line to end with CRLF (i.e. "\r\n")

 socket.print  "HTTP/1.1 200 OK\r\n" +
               "Content-Type: text/plain\r\n" +
               "Content-Length: #{response.bytesize}\r\n" +
               "Connection: close\r\n"


               # Print a blank line to separate the header from the response body,
                 # as required by the protocol.
                 socket.print "\r\n"

                 # Print the actual response body, which is just "Hello World!\n"
                 socket.print response

                 # Close the socket, terminating the connection
                 socket.close




end




# client = tcp_server.accept
#
# puts "Ready for a request"
# request_lines = []
# while line = client.gets and !line.chomp.empty?
#   request_lines << line.chomp
# end
#
# puts "Got this request:"
# puts request_lines.inspect
#
# puts "Sending response."
# response = "<pre>" + request_lines.join("\n") + "</pre>"
# output = "<html><head></head><body>#{response}</body></html>"
# headers = ["http/1.1 200 ok",
#           "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
#           "server: ruby",
#           "content-type: text/html; charset=iso-8859-1",
#           "content-length: #{output.length}\r\n\r\n"].join("\r\n")
# client.puts headers
# client.puts output
#
# puts ["Wrote this response:", headers, output].join("\n")
# client.close
# puts "\nResponse complete, exiting."
