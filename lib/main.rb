# frozen_string_literal: true

require "optparse"
require_relative "./config_utils"
require_relative "./global"
require_relative "./http_client"

def main
  Whirly.configure spinner: "dots"
  parse_options
  if ARGV.length >= 1
    parse_command(ARGV[0])
  else
    puts "Pass a command(get/post/put/delete)"
  end
end

def parse_options
  ARGV.options do |opts|
    opts.banner = "Usage:  #{File.basename($PROGRAM_NAME)} [OPTIONS] OTHER_ARGS"
    opts.separator ""
    opts.separator "Specific Options:"
    opts.separator "Common Options:"
    opts.on("-h", "--help", "Show this message.") do
      puts opts
      exit
    end
    opts.on("--env VALUE", "Environment name") do |e|
      Global::OPTIONS[:env] = e
    end
    begin
      opts.parse!
    rescue StandardError => e
      puts e.message
      exit
    end
  end
end

def parse_command(command)
  case command.downcase
  when "init"
    init
  when "get"
    send_get_request
  when "put"
    puts "Put request executing"
  when "post"
    puts "post request executing"
  when "delete"
    puts "Delete request executing"
  else
    puts "Invalid request method"
  end
end

def init
  config_util = ConfigUtils.new
  config_util.get_environment
  config_util.get_base_url
  config_util.get_auth_token_header_key
  config_util.get_auth_token_header_value
  config_util.save_config_as_json
end

def send_get_request
  if ARGV.length >= 2
    HttpClient.get_request
  else
    puts "Pass an endpoint. Eg., apibotrb get /check-weather"
  end
end

main
