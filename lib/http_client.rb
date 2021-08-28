# frozen_string_literal: true

require "httparty"
require_relative "./global"
require_relative "./config_utils"
require "json"
require "whirly"
require "paint"

class HttpClient
  include HTTParty
  config = ConfigUtils.class.get_config(env: Global.class.options[:env])
  base_uri config["base_url"]
  headers config["headers"]

  def self.get_request
    Whirly.start do
      Whirly.status = "Loading..."
      response = HttpClient.class.get(ARGV[1])
      HttpClient.class.pretty_print(response)
    end
  end

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
