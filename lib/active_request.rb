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
      else
        Hash.new
      end
    end
  end

  private

  def has_params?
    !query_string.empty?
  end

  def query_string
    env['query_string']
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
