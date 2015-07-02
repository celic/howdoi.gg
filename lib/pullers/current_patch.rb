# Require
require 'rubygems'
require 'json'
require 'open-uri'
require 'sinatra/activerecord'
require 'sinatra/config_file'

yaml = YAML.load_file("/config/database.yml")
yaml.each_pair do |key, value|
    set(key.to_sym, value)
end

puts yaml

#config_file "../../config/database.yml"

api_key = settings.development.api_key

puts api_key

#game_stats_file = open("https://global.api.pvp.net/api/lol/static-data/na/v1.2/realm?api_key=#{api_key}")

puts "done"