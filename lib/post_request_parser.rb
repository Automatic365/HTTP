class PostRequestParser
  attr_reader :parsed_request
  def initialize(request_lines)
    @request_lines = request_lines
    @parsed_request = Hash.new
  end

  def get_verb
    @request_line = @request_lines.shift
    @request_line.split.first
  end

  def get_path
    @request_line.split[1].split("?").first
  end

  def get_parameters
    @request_line.split[1].split("?").last
  end

  def get_protocol
    @request_line.split.last
  end

  def get_host
    @request_lines.find do |line|
      line.include?("Host")
    end.split(": ").last
  end

  def get_port
    @request_lines.find do |line|
      line.include?("Host")
    end.split(": ").last.split(":").last
  end

  def get_origin
    @request_lines.find do |line|
      line.include?("Host")
    end.split(": ").last.split(":").first
  end

  def get_accept
    @request_lines.find do
      |line|line.include?("Accept:")
    end.split(": ").last
  end

  def get_content_length
    @request_lines.find do |line|
      line.include?("Content-Length")
    end.split(": ").last
  end

  def voltron
    @parsed_request["Verb:"] = get_verb
    @parsed_request["Path:"] = get_path
    @parsed_request["Parameters:"] = get_parameters
    @parsed_request["Protocol:"] = get_protocol
    @parsed_request["Host:"] = get_host
    @parsed_request["Port:"] = get_port
    @parsed_request["Origin:"] = get_origin
    @parsed_request["Accept:"] = get_accept
    @parsed_request["Content-Length:"] = get_content_length
  end

end
