class Router
  attr_accessor :routes

  GET    = :get
  POST   = :post
  DELETE = :delete
  METHODS = [GET, POST, DELETE]

  def initialize
    empty_routes
  end

  def draw &block
    instance_eval &block
  end

  METHODS.each do |method|
    define_method(method) do |path, options|
      raise ArgumentError if path.nil? || path.empty?

      self.routes[method] << [path, options ||= {}]
    end
  end

  private

  def empty_routes
    self.routes = Hash.new
    METHODS.each { |method| self.routes[method] = [] }
  end
end
