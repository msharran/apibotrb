#!/usr/bin/env ruby

require_relative "./config_utils.rb"

def main
  if ARGV.length > 0
    parse_command(ARGV[0])
  else
    puts "Pass a command"
  end
end

def parse_command(command)
  case command.downcase
  when "init"
    init()
  when "get"
    puts "Get request executing"
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

main()
