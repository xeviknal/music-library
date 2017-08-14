class Route
  attr_accessor :path, :options

  def initialize(path, options)
    self.path     = path
    self.options  = options

    require_controller
  end

  def controller
    Object.const_get "#{controller_name.capitalize}Controller"
  end

  def action
    to.last.to_sym
  end

  private

  def controller_name
    to.first
  end

  def to
    options[:to] && options[:to].split('#')
  end

  def require_controller
    require File.join(File.dirname(__FILE__), '..', 'app',
                      'controllers', controller_name.downcase + '_controller.rb')
  end
end
