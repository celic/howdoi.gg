# Require
require 'rubygems'
require 'json'
require 'open-uri'
require 'sinatra/activerecord'

require_relative '../../models/champion'

# Find API key
db = YAML.load(ERB.new(File.read(File.join('config','database.yml'))).result)
api_key = db['api']['key']

current_champs_json = open("https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?api_key=#{api_key}")
current_champs_full = JSON.parse current_champs_json.read

champ_list = current_champs_full['data']

# Add list of champions
champ_list.each do |name, champ|

	# Check if champion is already in the db
	unless Champion.find_by name: champ['name']
		Champion.create(riot_id: champ['id'], name: name, desc: champ['title'], key: champ['key'], free: false)
	end
end

# Set all champions to not free
Champion.all.each do |champ|
	champ.free = false
end

# Get list of free champions
free_champs_json = open("https://na.api.pvp.net/api/lol/na/v1.2/champion?freeToPlay=true&api_key=#{api_key}")
free_champs_full = JSON.parse free_champs_json.read

free_champs_list = free_champs_full['champions']

free_champs_list.each do |champ_json|

	champ = Champion.find_by riot_id: champ_json['id']
	champ.free = true
	champ.save
end