require_relative '../lib/game'
require 'testhelper'

class GameTest < Test::Minitest


  def test_start_game
    request_lines = ["GET /game?guess=4 HTTP/1.1",
      "Host: localhost:9292",
      "Connection: keep-alive",
      "Cache-Control: no-cache",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Postman/4.2.2 Chrome/47.0.2526.73 Electron/0.36.2 Safari/537.36",
      "Postman-Token: 833907be-6bbe-41c5-3e4a-11e4191b3086",
      "Accept: */*",
      "Accept-Encoding: gzip, deflate",
      "Accept-Language: en-US"]

    game = Game.new(request_lines)

    assert_equal "4", game.game_check
  end

end
