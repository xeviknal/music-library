class Router
  attr_accessor :routes

  GET    = :get
  POST   = :post
  DELETE = :delete
  METHODS = [GET, POST, DELETE]

  def initialize
    self.routes = Hash.new([])
  end

  def get(path, options = {})
    raise ArgumentError if path.nil? || path.empty?

    self.routes[GET] << [path, options]
  end
end
