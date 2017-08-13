require 'pry'
require 'active_support'
require 'active_record'

module MusicLibrary
  class Application
    def call(env)
      # Gimme Controller/action out of Request path
      # initialize controller with request
      # call controller action
       ['200', {'Content-Type' => 'application/json'}, ['A barebones rack app.']]
    end
  end
end
