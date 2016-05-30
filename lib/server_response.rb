require_relative "request_parser"
class ServerResponse
  def initialize
    @count = -1
  end

  def response_parse(request_lines)
    @parser = RequestParser.new(request_lines)
    @request = @parser.request
    @parser.append
    path_check
  end

  def path_check
    if @request["Path:"]=="/hello"
      hello_response
    elsif @request["Path:"]=="/datetime"
      date
    else
      @request
    end
  end

  def hello_response
    @count += 1
    "<pre>Hello, World!(#{@count})</pre>"
  end

  def date
    Time.now.strftime('%l:%M%p on %A, %B %e, %Y ')
  end

  def shutdown
    "Total Requests: #{count}"
    close(client)
  end

  def close(client)
    client.close
  end

end
