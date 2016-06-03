require_relative '../lib/response_redirect'
require 'minitest/autorun'
require 'minitest/pride'

class ResponseRedirectTest < Minitest::Test
  def setup
    @response_redirect = ResponseRedirect.new
    @response_redirect.create_redirect({"Verb:"=>"POST", "Path:"=>"/game", "Parameters:"=>"/game",
                                        "Protocol:"=>"HTTP/1.1",
                                        "Host:"=>"127.0.0.1:9494", "Port:"=>"9494",
                                        "Origin:"=>"127.0.0.1", "Accept:"=>"*/*", "Content-Length:"=>"7"})
  end

  def test_can_retrieve_protocol
    skip
    assert_equal "HTTP/1.1", @response_redirect.get_protocol
  end

  def test_can_get_status_code
    skip
    assert_equal "302 Redirection", @response_redirect.get_status_code
  end

  def test_can_get_status_line
    skip
    assert_equal "HTTP/1.1 302 Redirection", @response_redirect.get_status_line
  end

  def test_can_get_location
    skip
    assert_equal "Location: 127.0.0.1:9494/game", @response_redirect.get_location
  end

  def test_can_get_content_type
    skip
    assert_equal "content-type: text/html; charset=iso-8859-1", @response_redirect.get_content_type
  end

  def test_get_date
    skip
    assert_equal "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}", @response_redirect.get_date
  end

  def test_get_server
    skip
    assert_equal "server: ruby", @response_redirect.get_server
  end

  def test_content_length
    skip
    assert_equal "Content-Length: 7", @response_redirect.get_content_length
  end
end
