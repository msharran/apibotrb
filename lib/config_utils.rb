# frozen_string_literal: true

require "json"
require "fileutils"

class ConfigUtils
  CONFIG_DIR = "#{Dir.home}/.apibotrb"
  CONFIG_PATH = "#{CONFIG_DIR}/config.json"

  attr_accessor :configs

  def initialize
    puts "Hi, I am ApiBot!"
    print "You can have multiple environments of API requests and easily switch between them. "
    puts "To create an environment please follow the steps,\n"
    puts "Note: I have created some default values for easily getting started."
    puts "Press enter for using default value."

    @configs = File.exist?(CONFIG_PATH) ? ConfigUtils.read_configs : {}
    @env = "dev"
  end

  def self.read_configs
    config = File.open CONFIG_PATH
    config_json = JSON.load config
    config.close
    config_json
  end

  def self.get_config(env:)
    ConfigUtils.read_configs[env]
  end

  def get_environment
    puts "Enter the environment name: [dev]"
    env = $stdin.gets.chomp
    @env = env if env.empty? == false
    @configs[@env] = {} if @configs.key?(@env) == false
  end

  def get_base_url
    puts "Enter the Base URL: ['']"
    env = $stdin.gets.chomp
    @configs[@env]["base_url"] = env.empty? ? "" : env
  end

  def get_auth_token_header_key
    puts "Enter the authorization token header key: [Authorization]"
    env = $stdin.gets.chomp
    @configs[@env]["token_key"] = env.empty? ? "Authorization" : env
  end

  def get_auth_token_header_value
    puts "Enter the authorization token header value. Eg., Bearer asda23245tfasd: ['']"
    env = $stdin.gets.chomp
    @configs[@env]["token_value"] = env.empty? ? "" : env
  end

  def save_config_as_json
    FileUtils.mkdir_p CONFIG_DIR
    File.open(CONFIG_PATH, "w") do |config|
      config.write(JSON.pretty_generate(@configs))
      puts "Config saved successfully in #{CONFIG_PATH}"
    end
  end
end
