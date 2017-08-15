require 'pry'
require 'active_support'
require 'active_record'

Dir['./lib/**/*.rb'].each { |f| require f }

module MusicLibrary
  class Application
    attr_reader :router

    def initialize
      @router = Router.new
    end

    def call(env)
      request     = ActiveRequest.new(env)
      route       = router.route_for(request)

      if route
        controller  = route.controller.new(request)
        controller.send(route.action)
      else
        Response.not_found
      end.to_rack
    end
  end
end
