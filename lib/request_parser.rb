class RequestParser
  attr_reader :request_lines
  def initialize(request_lines)
    @request_lines = request_lines
  end

  def get_verb
    verb = @request_lines.first.split.first
  end

  def get_path
    path = @request_lines.first.split[1]
  end

  def get_protocol
    protocol = @request_lines.first.split.last
  end

  def get_host
    host = @request_lines.find_all do |line|
      line.include?("Host")
    end.join.split(": ").last
  end

  def get_port
    port = @request_lines.find_all do |line|
      line.include?("Host")
    end.join.split(":").last
  end

  def get_origin
    origin = @request_lines.find_all do |line|
      line.include?("Host")
    end.join.split(":")[1].lstrip
  end

  def get_accept
    accept = @request_lines.find do |line|
      line.split(":").include?("Accept")
    end.split(": ").last
  end
end
