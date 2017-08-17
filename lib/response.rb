class Response
  attr_accessor :body, :status_code, :header

  def initialize
    self.header = {
      'Content-Type' => 'application/json',
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Request-Method' => '*'
    }
  end

  def to_rack
    [status_code, header, [body]]
  end

  def self.not_found
    response = self.new
    response.status_code  = 404
    response.body         = '<html><body><h1>Something went wrong</h1></body></html>'
    response.header       = {
      'Content-Type' => 'text/html',
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Request-Method' => '*'
    }

    response
  end

  def self.empty
    response = self.new
    response.status_code  = 501
    response.body         = '<html><body><h1>Couldn\'t fulfil the request</h1></body></html>'
    response.header       = {
      'Content-Type' => 'text/html',
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Request-Method' => '*'
    }

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

  def self.preflight
    response = self.new
    response.status_code  = 200
    response.body         = ''
    response.header       = {
      'Content-Type' => 'application/json',
      'Access-Control-Allow-Origin'=>'*',
      'Access-Control-Request-Method'=>'*',
      'Access-Control-Allow-Methods' => 'POST, GET, DELETE',
      'Access-Control-Allow-Headers' => 'Content-Type, Access-Control-Allow-Headers, Access-Control-Allow-Methods, Authorization, X-Requested-With'
    }

    response
  end

end
