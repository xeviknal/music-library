class Response
  attr_accessor :body, :status_code, :header

  def initialize
    self.header = { 'Content-Type' => 'application/json' }
  end

  def to_rack
    [status_code, header, [body]]
  end

  def self.not_found
    response = self.new
    response.status_code  = 404
    response.header       = { 'Content-Type' => 'text/html' }
    response.body   = '<html><body><h1>Something went wrong</h1></body></html>'

    response
  end

  def self.empty
    response = self.new
    response.status_code  = 501
    response.header       = { 'Content-Type' => 'text/html' }
    response.body   = '<html><body><h1>Couldn\'t fulfil the request</h1></body></html>'

    response
  end

  def self.success
    response = self.new
    response.status_code  = 200
    response.body   = ''

    response
  end

  def self.failure
    response = self.new
    response.status_code  = 500
    response.body   = ''

    response
  end
end
