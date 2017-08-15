require 'pry'

require './config/environment'
MusicLibraryApp = MusicLibrary::Application.new

Dir['./config/*.rb'].each { |f| require f }
Dir['./lib/*.rb'].each { |f| require f }
Dir['./spec/support/*.rb'].each { |f| require f }
