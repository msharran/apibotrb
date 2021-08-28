require "httparty"
require_relative "./global.rb"
require_relative "./config_utils.rb"
require "json"

class HttpClient
  include HTTParty
  config = ConfigUtils::get_config(env: Global::OPTIONS[:env])
  base_uri config["base_url"]
  headers config["headers"]

  def self.pretty_print(response)
    puts Global::DIVIDER
    puts response.request.uri
    puts Global::DIVIDER
    puts "#{response.code} #{response.message}"
    puts Global::DIVIDER
    puts response.body
    puts Global::DIVIDER
  end
end
