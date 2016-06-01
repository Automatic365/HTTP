# require_relative '../lib/http_runner'
require 'faraday'
require './test/testhelper'
require 'pry'

class HTTPRunnerTest < Minitest::Test
  def test_faraday_works
    response = Faraday.get('http:127.0.0.1:9494')

    assert response.body.include?("Path: /")
    assert response.body.include?("Protocol:")
  end

  def test_hello_response
    skip
  
    response = Faraday.get('http://127.0.0.1:9494/hello')
    assert response.body.include?("Hello World!")
  end
end
