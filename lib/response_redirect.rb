require_relative 'post_request_parser'
require_relative 'word_search'
require_relative 'game'

class ResponseRedirect
  attr_accessor :redirect_headers
  def create_redirect(parsed_request)
    @parsed_request = parsed_request
    @redirect_headers = Array.new
    voltron
  end

  def get_protocol
    @parsed_request["Protocol:"]
  end

  def get_status_code
    "302 Found"
  end

  def get_status_line
    get_protocol + " " + get_status_code
  end

  def get_location
    "Location: " + @parsed_request["Host:"] + @parsed_request["Path:"]
  end

  def get_content_type
    "content-type: text/html; charset=iso-8859-1"
  end

  def get_date
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}"
  end

  def get_server
    "server: ruby"
  end

  def get_content_length
    "Content-Length: " + @parsed_request["Content-Length:"]
  end

  def voltron

    @redirect_headers.push(get_status_line)
    @redirect_headers.push(get_location)
    @redirect_headers.push(get_content_type)
    @redirect_headers.push(get_date)
    @redirect_headers.push(get_server)
    @redirect_headers.push(get_content_length + "\r\n\r\n")
  end
end
