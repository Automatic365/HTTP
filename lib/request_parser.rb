require 'pry'

class RequestParser
  attr_reader :request_lines, :request
  def initialize(request_lines)
    @request_lines = request_lines
    @request = Hash.new
  end

  def get_verb
    verb = @request_lines.first.split.first
  end

  def get_path
    path = @request_lines.first.split[1]
  end

  def get_protocol
    protocol = @request_lines.first.split.last
    @request["Protocol:"] = protocol
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

  def append
    @request["Verb:"] = get_verb
    @request["Path:"] = get_path
    @request["Protocol:"] = get_protocol
    @request["Host:"] = get_host
    @request["Port:"] = get_port
    @request["Origin:"] = get_origin
    @request["Accept:"] = get_accept
  end
end
