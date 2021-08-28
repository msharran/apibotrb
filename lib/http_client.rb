require "httparty"

class HttpClient
  attr_accessor :headers => {}

  def initialize(options)
    @options = options
  end
end
