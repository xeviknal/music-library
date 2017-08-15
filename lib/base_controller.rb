class BaseController
  attr_accessor :request, :params

  def initialize(request)
    self.request = request
    self.params  = request.params
  end

  protected

  def render(object, options = {})
    # options[:serializer] => object is a single object
    # options[:each_serializer] => object is a collection of objects
    return Response.empty if object.nil?

    body = if options[:serializer]
      render_single object, options.fetch(:serializer)
    elsif options[:each_serializer]
      render_collection object, options.fetch(:each_serializer)
    else
      render_plain object
    end

    build_response(body, options)
  end

  private

  def render_plain(object)
    JSON.generate(object)
  end

  def render_single(object, serializer)
    serializer.new(object).to_json
  end

  def render_collection(collection, serializer)
    collection.map do |item|
      render_single(item, serializer)
    end
  end

  def build_response(body, options)
    response = Response.new
    response.status_code  = 200
    response.body         = body

    response
  end
end
