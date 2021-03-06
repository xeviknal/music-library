require 'active_support/hash_with_indifferent_access'

class ActiveRequest
  attr_accessor :env

  def initialize(environment)
    self.env = environment.with_indifferent_access
  end

  def params
    @params ||= begin
      if has_params?
        parse_query_string
      elsif has_body?
        parse_body_json
      else
        Hash.new
      end
    end
  end

  def method
    @method ||= env['REQUEST_METHOD'].downcase.to_sym
  end

  def path
    @path ||= env['PATH_INFO']
  end

  def preflight?
    method == Router::OPTIONS
  end

  private

  def has_body?
    !body_input.nil? && !body_input.empty?
  end

  def body_input
    @request_body ||= env['rack.input']&.read
  end

  def parse_body_json
    JSON.parse(body_input).with_indifferent_access
  end

  def has_params?
    !query_string.nil? && !query_string.empty?
  end

  def query_string
    env['QUERY_STRING']
  end

  def parse_query_string
    query_params = ActiveSupport::HashWithIndifferentAccess.new

    splitted_query_string.each do |param|
      name, value = param.split('=')
      query_params[name] = parse_param value
    end

    query_params
  end

  def splitted_query_string
    query_string.split('&')
  end

  def parse_param(value)
    Integer(value)
  rescue
    value
  end
end
