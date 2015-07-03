# Require
require 'rubygems'
require 'json'
require 'open-uri'
require 'sinatra/activerecord'

require_relative '../../models/player'
require_relative '../../models/game'

# Find API key
db = YAML.load(ERB.new(File.read(File.join('config','database.yml'))).result)
api_key = db['api']['key']

test_players = Players.all(1..5)

test_players.all.each do |player|

	player_id = player.riot_id
	player_games_json = open("https://na.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{player_id}/recent?api_key=#{api_key}")
	player_games_full = JSON.parse player_games_json.read
	player_games_list = player_games_full['games']

	player_games_list.each do |game|

	end
end