# Require
require 'rubygems'
require 'json'
require 'open-uri'
require 'sinatra/activerecord'

require_relative '../../models/champion'

# Find API key
db = YAML.load(ERB.new(File.read(File.join('config','database.yml'))).result)
api_key = db['api']['key']

current_champs_json = open('https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=info&api_key=#{api_key}')
current_champs_full = JSON.parse current_champs_json.read

champ_list = current_champs_full['data']

# Add list of champions
champ_list.each do |champ|

	# Check if champion is already in the db
	if Champion.find_by name: champ['name'] == nil
		Champion.create(riot_id: champ['id'], name: champ['name'], desc: champ['title'])
	end
end