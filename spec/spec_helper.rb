require 'pry'
require 'database_cleaner'

ENV['MUSIC_ENV'] ||= 'test'

require './config/environment'
MusicLibraryApp = MusicLibrary::Application.new

Dir['./config/*.rb'].each { |f| require f }
Dir['./lib/*.rb'].each { |f| require f }
Dir['./spec/support/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
