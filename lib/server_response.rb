class ServerResponse
  def initialize
    @count = -1
  end

  def hello_response
    @count += 1
    "<pre>Hello, World!(#{@count})</pre>"
  end

  def date
    Time.now.strftime('%l:%M%p on %A, %B %e, %Y ')
  end

  def shutdown(count=-1)
    count += 1
    "Total Requests: #{count}"
    close(client)
  end

  def close(client)
    client.close
  end

end
