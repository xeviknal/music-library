class Router
  attr_accessor :routes

  GET    = :get
  POST   = :post
  DELETE = :delete
  METHODS = [GET, POST, DELETE]

  def initialize
    self.routes = Hash.new([])
  end

  METHODS.each do |method|
    define_method(method) do |path, options|
      raise ArgumentError if path.nil? || path.empty?

      self.routes[method] << [path, options ||= {}]
    end
  end
end
