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
      # Gimme Controller/action out of Request path
      # initialize controller with request
      # call controller action
       ['200', {'Content-Type' => 'application/json'}, ['A barebones rack app.']]
    end
  end
end
