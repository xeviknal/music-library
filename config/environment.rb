module MusicLibrary
  class Application
    def call(env)
       ['200', {'Content-Type' => 'text/html'}, ['A barebones rack app.']]
    end
  end
end
