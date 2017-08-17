require_relative('route')

class Router
  attr_accessor :routes

  GET     = :get
  POST    = :post
  DELETE  = :delete
  OPTIONS = :options
  METHODS = [GET, POST, DELETE, OPTIONS]

  def initialize
    empty_routes
  end

  def draw &block
    instance_eval &block
  end

  def route_for(request)
    route = routes[request.method].detect do |path, _|
      path == request.path
    end

    Route.new(*route) if route
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
