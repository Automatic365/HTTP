require_relative '../lib/server_response'
require 'minitest/autorun'
require 'minitest/pride'

class ServerResponseTest < Minitest::Test
  def test_hello_response
    server_response = ServerResponse.new

    assert_equal "<pre>Hello, World!(0)</pre>", server_response.hello_response

    server_response.hello_response

    assert_equal "<pre>Hello, World!(2)</pre>", server_response.hello_response
  end


end
