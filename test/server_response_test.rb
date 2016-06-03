require_relative '../lib/server_response'
require 'minitest/autorun'
require 'minitest/pride'

class ServerResponseTest < Minitest::Test
  def setup
    @server_response = ServerResponse.new
  end

  def test_identify_datetime
    request_lines_datetime = ["GET /datetime HTTP/1.1",
      "Host: localhost:9292",
      "Connection: keep-alive",
      "Cache-Control: no-cache",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Postman/4.2.2 Chrome/47.0.2526.73 Electron/0.36.2 Safari/537.36",
      "Postman-Token: 833907be-6bbe-41c5-3e4a-11e4191b3086",
      "Accept: */*",
      "Accept-Encoding: gzip, deflate",
      "Accept-Language: en-US"]

      assert_equal Time.now.strftime('%l:%M%p on %A, %B %e, %Y'), @server_response.format_response(request_lines_datetime)
  end

  def test_identidy_word_search

    request_lines_word_search = ["GET /word_search?word=aardvark HTTP/1.1",
      "Host: localhost:9292",
      "Connection: keep-alive",
      "Cache-Control: no-cache",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Postman/4.2.2 Chrome/47.0.2526.73 Electron/0.36.2 Safari/537.36",
      "Postman-Token: 833907be-6bbe-41c5-3e4a-11e4191b3086",
      "Accept: */*",
      "Accept-Encoding: gzip, deflate",
      "Accept-Language: en-US"]

      assert "<pre>aardvark is a word</pre>", @server_response.format_response(request_lines_word_search)
  end

  def test_general_format_for_blank_path
    request_lines_general = ["GET / HTTP/1.1",
      "Host: localhost:9292",
      "Connection: keep-alive",
      "Cache-Control: no-cache",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Postman/4.2.2 Chrome/47.0.2526.73 Electron/0.36.2 Safari/537.36",
      "Postman-Token: 833907be-6bbe-41c5-3e4a-11e4191b3086",
      "Accept: */*",
      "Accept-Encoding: gzip, deflate",
      "Accept-Language: en-US"]

      formatted_response = @server_response.format_response(request_lines_general)

    assert formatted_response.include?("Verb:")
    assert formatted_response.include?("Path:")
    assert formatted_response.include?("Protocol:")
    assert formatted_response.include?("Host:")
    assert formatted_response.include?("Port:")
    assert formatted_response.include?("Origin:")
    assert formatted_response.include?("Accept:")
  end
end
