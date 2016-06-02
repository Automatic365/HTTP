require_relative '../lib/post_request_parser'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'Faraday'

class PostRequestParserTest < Minitest::Test
  def setup
    request_lines = ["POST /game?guess=4 HTTP/1.1",
                     "User-Agent: Faraday v0.9.2",
                     "Content-Type: application/x-www-form-urlencoded",
                     "Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
                     "Accept: */*",
                     "Connection: close",
                     "Host: 127.0.0.1:9494",
                     "Content-Length: 7"]

    @request_parser = PostRequestParser.new(request_lines)
  end

  def test_get_verb
    assert_equal "POST", @request_parser.get_verb
  end

  def test_get_path
    assert_equal "/game", @request_parser.get_path
  end

  def test_get_parameters
    assert_equal "guess=4", @request_parser.get_parameters
  end

  def test_get_protocol
    assert_equal "HTTP/1.1", @request_parser.get_protocol
  end

  def test_get_hot
    assert_equal "127.0.0.1:9494", @request_parser.get_host
  end

  def test_get_content_length
    assert_equal "7", @request_parser.get_content_length
  end
end
