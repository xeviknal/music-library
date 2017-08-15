require 'pry'
require 'active_support'
require 'active_record'

Dir['./lib/**/*.rb'].each { |f| require f }
Dir['./app/models/*.rb'].each { |f| require f }

module MusicLibrary
  class Application
    attr_reader :router

    def initialize
      @router = Router.new
      establish_connection
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

    private

    def establish_connection
      database_config = YAML.load_file("./config/database.yml")
      ActiveRecord::Base.establish_connection(
        adapter:  database_config["adapter"],
        database: "db/#{database_config["database"]}.sqlite3",
        pool:     database_config["pool"],
        timeout:  database_config["timeout"]
      )
    end
  end
end
