class BaseController
  attr_accessor :request, :params

  def initialize(request)
    self.request = request
    self.params  = request.params
  end

  protected

  def render(object, options = {})
    return Response.empty if object.nil?

    body = serialize(object, options)
    build_response(body, options)
  end

  def render_success
    Response.success
  end

  def render_failure
    Response.failure
  end

  private

  def serialize(object, options)
    if object.respond_to? :to_json
      render_single object, options
    else
      render_plain object
    end
  end

  def render_plain(object)
    JSON.generate(object)
  end

  def render_single(object, options)
    object.to_json
  end

  def render_collection(collection, options)
    collection.map do |item|
      serialize(item, options)
    end
  end

  def build_response(body, options)
    response = Response.new
    response.status_code  = 200
    response.body         = body

    response
  end
end
