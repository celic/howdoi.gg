# Require
require 'rubygems'
require 'json'
require 'open-uri'
require 'sinatra/activerecord'

require_relative '../../models/player'

# Find API key
db = YAML.load(ERB.new(File.read(File.join('config','database.yml'))).result)
api_key = db['api']['key']

#### FILE IS LIMITED TO CHALLENGER FOR TESTING PURPOSES

#### master_player_json = open("https://na.api.pvp.net/api/lol/na/v2.5/league/master?type=RANKED_SOLO_5x5&api_key=#{api_key}")
challenger_player_json = open("https://na.api.pvp.net/api/lol/na/v2.5/league/challenger?type=RANKED_SOLO_5x5&api_key=#{api_key}")

#### master_player_full = JSON.parse master_player_json.read
challenger_player_full = JSON.parse challenger_player_json.read

#### master_player_list = master_player_full['entries']
challenger_player_list = challenger_player_full['entries']

# Clear previous challenger and master players
Player.delete_all

# Refill database
challenger_player_list.each do |player|
	Player.create(name: player['playerOrTeamName'], riot_id: player['playerOrTeamId'])
end

#### master_player_list.each do |player|
####	 Player.create(name: player['playerOrTeamName'], riot_id: player['playerOrTeamId'])
#### end