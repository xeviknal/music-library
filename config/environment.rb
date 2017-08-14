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
      route       = self.router.route_for(request)
      #controller  = route.controller.new(request)
      #response    = controller.send(route.action)
      #response.to_rack
       ['200', {'Content-Type' => 'application/json'}, ['A barebones rack app.']]
    end
  end
end
