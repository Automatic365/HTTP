
require_relative 'testhelper'
require_relative '../lib/response_header_formatter'

class ResponseHeaderFormatterTest < Minitest::Test
  def setup
    @formatter = ResponseHeaderFormatter.new
  end

  def test_can_form_response_game_path
    request_lines_game = ["POST /start_game HTTP/1.1",
      "Host: localhost:9292",
      "Connection: keep-alive",
      "Cache-Control: no-cache",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Postman/4.2.2 Chrome/47.0.2526.73 Electron/0.36.2 Safari/537.36",
      "Postman-Token: 833907be-6bbe-41c5-3e4a-11e4191b3086",
      "Accept: */*",
      "Accept-Encoding: gzip, deflate",
      "Accept-Language: en-US"]

      assert @formatter.form_response(request_lines_game).include?("Good Luck")
  end

  def test_can_form_response_shutdown

    request_lines_shutdown = ["GET /shutdown HTTP/1.1",
      "Host: localhost:9292",
      "Connection: keep-alive",
      "Cache-Control: no-cache",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Postman/4.2.2 Chrome/47.0.2526.73 Electron/0.36.2 Safari/537.36",
      "Postman-Token: 833907be-6bbe-41c5-3e4a-11e4191b3086",
      "Accept: */*",
      "Accept-Encoding: gzip, deflate",
      "Accept-Language: en-US"]

      assert @formatter.form_response(request_lines_shutdown).include?("Total Requests:")
  end

  def test_can_form_hello_response

    request_lines_hello = ["GET /hello HTTP/1.1",
      "Host: localhost:9292",
      "Connection: keep-alive",
      "Cache-Control: no-cache",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Postman/4.2.2 Chrome/47.0.2526.73 Electron/0.36.2 Safari/537.36",
      "Postman-Token: 833907be-6bbe-41c5-3e4a-11e4191b3086",
      "Accept: */*",
      "Accept-Encoding: gzip, deflate",
      "Accept-Language: en-US"]


      assert @formatter.form_response(request_lines_hello).include?("Hello, World")

  end

  def test_can_form_general

    request_lines = ["GET / HTTP/1.1",
      "Host: localhost:9292",
      "Connection: keep-alive",
      "Cache-Control: no-cache",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Postman/4.2.2 Chrome/47.0.2526.73 Electron/0.36.2 Safari/537.36",
      "Postman-Token: 833907be-6bbe-41c5-3e4a-11e4191b3086",
      "Accept: */*",
      "Accept-Encoding: gzip, deflate",
      "Accept-Language: en-US"]

      assert @formatter.form_response(request_lines).include?("Verb:")
      assert @formatter.form_response(request_lines).include?("Path:")
      assert @formatter.form_response(request_lines).include?("Protocol:")
      assert @formatter.form_response(request_lines).include?("Host:")
      assert @formatter.form_response(request_lines).include?("Port:")
      assert @formatter.form_response(request_lines).include?("Origin:")
      assert @formatter.form_response(request_lines).include?("Accept:")
  end
end
