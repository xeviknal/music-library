require 'rack'
require_relative 'config/environment'

Rack::Handler::WEBrick.run MusicLibrary::Application.new, Port: 8000
