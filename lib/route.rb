class Route
  attr_accessor :path, :options

  def initialize(path, options)
    self.path     = path
    self.options  = options
  end
end
