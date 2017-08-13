require 'rack'
require_relative 'config/environment'

MusicLibraryApp = MusicLibrary::Application.new

require_relative 'config/routes'

Rack::Handler::WEBrick.run MusicLibraryApp, Port: 8000
