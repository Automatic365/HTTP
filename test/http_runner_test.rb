require 'faraday'
require './test/testhelper'
require 'pry'
require_relative '../lib/server_response'

class HTTPRunnerTest < Minitest::Test

  def test_faraday_post

    conn = Faraday.get('http://127.0.0.1:9494/word_search?word=animal',:word => "animal")

    assert conn.body.include?("animal is a word")
  end

  def test_faraday_works

    conn = Faraday.new
    response = conn.get('http://127.0.0.1:9494/')
    assert response.body.include?("Path: /")
    assert response.body.include?("Protocol:")
  end

  def test_hello_response

    conn = Faraday.get('http://127.0.0.1:9494/hello')

    assert conn.body.include?("Hello, World!")
  end

  def test_datetime
    conn = Faraday.get('http://127.0.0.1:9494/datetime')

    assert conn.body.include?(Time.now.strftime('%l:%M%p on %A, %B %e, %Y'))
  end

  def test_word_search
    conn = Faraday.get('http://127.0.0.1:9494/word_search?word=aardvark')

    assert conn.body.include?("aardvark is a word")
  end

  def test_word_search_bad_word
    conn = Faraday.get('http://127.0.0.1:9494/word_search?word=adakdms')

    assert conn.body.include?("adakdms is not a word")
  end
end
