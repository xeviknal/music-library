require 'pry'

Dir['./config/*.rb'].each { |f| require f }
Dir['./lib/*.rb'].each { |f| require f }
