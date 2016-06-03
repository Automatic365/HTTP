require_relative '../lib/request_parser'
require 'minitest/autorun'
require 'minitest/pride'

class RequestParserTest < Minitest::Test
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

      @parser = RequestParser.new(@request_lines)
  end

  def test_get_verb
    assert_equal "GET", @parser.get_verb

  end

  def test_get_path
    assert_equal "/", @parser.get_path
  end

  def test_get_protocol
    assert_equal "HTTP/1.1", @parser.get_protocol
  end

  def test_get_host
    assert_equal "localhost:9292", @parser.get_host
  end

  def test_get_port
    assert_equal "9292", @parser.get_port
  end

  def test_get_origin
    assert_equal "localhost", @parser.get_origin
  end

  def test_get_accept
    assert_equal "*/*", @parser.get_accept
  end

end
