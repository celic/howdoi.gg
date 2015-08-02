# Require
require 'rubygems'
require 'json'
require 'open-uri'
require 'sinatra/activerecord'

require_relative '../../models/item'

# Find API key
db = YAML.load(ERB.new(File.read(File.join("config","database.yml"))).result)
api_key = db['api']['key']

current_items_json = open("https://global.api.pvp.net/api/lol/static-data/na/v1.2/item?&api_key=#{api_key}")
current_items_full = JSON.parse current_items_json.read

items_list = current_items_full['data']

# Purge items
Item.delete_all

# Add list of items
items_list.each do |item|

    id = item[1]["id"]
    
    current_item = open("https://global.api.pvp.net/api/lol/static-data/na/v1.2/item/#{id}?itemData=gold&api_key=#{api_key}")
    item_spec = JSON.parse current_item.read
    
    gold_value = item_spec["gold"]["total"]

	# Add to the db
	Item.create(riot_id: item[1]["id"], name: item[1]["name"], desc: item[1]["description"], gold_value: gold_value)
end