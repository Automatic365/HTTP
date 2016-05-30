require_relative '../lib/server_response'
require 'minitest/autorun'
require 'minitest/pride'

class ServerResponseTest < Minitest::Test
  def setup
    @request_lines = ["GET / HTTP/1.1",
      "Host: localhost:9292",
      "Connection: keep-alive",
      "Cache-Control: no-cache",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Postman/4.2.2 Chrome/47.0.2526.73 Electron/0.36.2 Safari/537.36",
      "Postman-Token: 833907be-6bbe-41c5-3e4a-11e4191b3086",
      "Accept: */*",
      "Accept-Encoding: gzip, deflate",
      "Accept-Language: en-US"]

    @server_response = ServerResponse.new
  end
  def test_hello_response
    skip
    assert_equal "<pre>Hello, World!(0)</pre>", @server_response.hello_response

    @server_response.hello_response

    assert_equal "<pre>Hello, World!(2)</pre>", @server_response.hello_response
  end

  def test_hello_response
    request_lines = ["GET /hello HTTP/1.1",
      "Host: localhost:9292",
      "Connection: keep-alive",
      "Cache-Control: no-cache",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Postman/4.2.2 Chrome/47.0.2526.73 Electron/0.36.2 Safari/537.36",
      "Postman-Token: 833907be-6bbe-41c5-3e4a-11e4191b3086",
      "Accept: */*",
      "Accept-Encoding: gzip, deflate",
      "Accept-Language: en-US"]

      assert_equal "<pre>Hello, World!(0)</pre>", @server_response.response_parse(request_lines)
  end

  def test_datetime
    request_lines = ["GET /datetime HTTP/1.1",
      "Host: localhost:9292",
      "Connection: keep-alive",
      "Cache-Control: no-cache",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Postman/4.2.2 Chrome/47.0.2526.73 Electron/0.36.2 Safari/537.36",
      "Postman-Token: 833907be-6bbe-41c5-3e4a-11e4191b3086",
      "Accept: */*",
      "Accept-Encoding: gzip, deflate",
      "Accept-Language: en-US"]


    assert_equal Time.now.strftime('%l:%M%p on %A, %B %e, %Y '), @server_response.response_parse(request_lines)
  end

end
