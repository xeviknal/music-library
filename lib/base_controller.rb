class BaseController
  attr_accessor :request, :params

  def initialize(request)
    self.request = request
    self.params  = request.params
  end
end
