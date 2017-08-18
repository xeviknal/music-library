require 'rack'
require_relative 'config/application'

ENV['MUSIC_ENV'] ||= 'development'

MusicLibraryApp = MusicLibrary::Application.new

require_relative 'config/routes'

Rack::Handler::WEBrick.run MusicLibraryApp, Port: 8000
