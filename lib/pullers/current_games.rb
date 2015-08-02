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

# Toggle for testing purposes
# players = Player.all
players = Player.all.take(2)

players.each do |player|

	player_id = player.riot_id
	player_games_json = open("https://na.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{player_id}/recent?api_key=#{api_key}")
	player_games_full = JSON.parse player_games_json.read
	player_games_list = player_games_full['games']

    # Limit API hits for testing
    games_list = player_games_list.all.take(5)

	player_games_list.each do |game|

        game_in_db = Game.find_by riot_id: game['gameId']

        # Determine and store game data 
		unless game_in_db
    
            # Skip if it wasn't a ranked game
            next if game['subType'] != 'RANKED_SOLO_5x5' or game['subType'] != 'RANKED_PREMADE_5x5'
    
			# Collect arrays of players
			game_players = game['fellowPlayers']
			blue_team = red_team = []

			game_players.each do |player|
				blue_team << player['championId'] if player['teamId'] == 100 
				red_team << player['championId']  if player['teamId'] == 200
			end

			# Lazily add current player to which ever team has only 4
			blue_team << game['championId'] if blue_team.count == 4
			red_team << game['championId'] if red_team.count == 4

            # Determine game winner
			winner = game['stats']['win']
			
			# Determine game time
			seconds = game['stats']['timePlayed']

            # Create database entry
			game_in_db = Game.create(riot_id: game['gameId'], blue_team: blue_team, red_team: red_team, winner: winner, time: seconds)
		end
		
		# Find and store player build
		
		# Determine champion
		champion = game['championId']
		
		# Determine summoner spells and sort (to ignore d/f flash differences)
		summoner_spells = [game['spell1'], game['spell2']].sort
		
		# Determine role 
		role = game['stats']['playerPosition']
		if role == 4 and game['stats']['playerRole'] == 2 
		    role = 5
		end
		
		# Determine end game build
		items = [game['stats']['item0'], game['stats']['item1'], game['stats']['item2'], game['stats']['item3'], game['stats']['item4'], game['stats']['item5'], game['stats']['item6']]
		items.each do |item|
		    if item.nil?
		        item = -1 
		    end
		end 
		
		# Create and save build
		Build.create(champion_id: champion, summoner_spells: summoner_spells, role: role, items: items)
	end
end
