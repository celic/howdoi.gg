# Require
require 'rubygems'
require 'json'
require 'open-uri'
require 'sinatra/activerecord'

require_relative '../../models/patch'

# Find API key
db = YAML.load(ERB.new(File.read(File.join("config","database.yml"))).result)
api_key = db['api']['key']

current_patch_json = open("https://global.api.pvp.net/api/lol/static-data/na/v1.2/realm?api_key=#{api_key}")
current_patch_full = JSON.parse current_patch_json.read

current_patch = current_patch_full['dd']

last_patch = Patch.last

if last_patch != nil

	# New patch found
	if current_patch != Patch.last.number
		
		# Create patch
		Patch.create(number: current_patch)

		# Initialize champion puller
		require_relative 'current_champions'
	end
else

	# No patches at all
	Patch.create(number: current_patch)
end