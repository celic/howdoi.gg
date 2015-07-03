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

		unless Game.find_by riot_id: game['gameId']
			#Game.create(riot_id: champ['id'], name: name, desc: champ['title'], key: champ['key'], free: false)
		end
	end
end

# {
#          "fellowPlayers": [
#             {
#                "championId": 92,
#                "teamId": 200,
#                "summonerId": 39439835
#             },
#             {
#                "championId": 83,
#                "teamId": 200,
#                "summonerId": 53408684
#             },
#             {
#                "championId": 245,
#                "teamId": 100,
#                "summonerId": 22230929
#             },
#             {
#                "championId": 236,
#                "teamId": 200,
#                "summonerId": 36759608
#             },
#             {
#                "championId": 91,
#                "teamId": 100,
#                "summonerId": 24719381
#             },
#             {
#                "championId": 45,
#                "teamId": 200,
#                "summonerId": 55852966
#             },
#             {
#                "championId": 412,
#                "teamId": 200,
#                "summonerId": 39613715
#             },
#             {
#                "championId": 1,
#                "teamId": 100,
#                "summonerId": 60930346
#             },
#             {
#                "championId": 63,
#                "teamId": 100,
#                "summonerId": 51503455
#             }
#          ],
#          "gameType": "MATCHED_GAME",
#          "stats": {
#             "totalDamageDealtToChampions": 5726,
#             "goldEarned": 5627,
#             "item2": 2003,
#             "item1": 1001,
#             "wardPlaced": 4,
#             "totalDamageTaken": 22951,
#             "item0": 3708,
#             "trueDamageDealtPlayer": 5651,
#             "physicalDamageDealtPlayer": 5239,
#             "trueDamageDealtToChampions": 220,
#             "visionWardsBought": 1,
#             "totalUnitsHealed": 1,
#             "playerPosition": 3,
#             "level": 10,
#             "neutralMinionsKilledYourJungle": 44,
#             "magicDamageDealtToChampions": 5454,
#             "magicDamageDealtPlayer": 52558,
#             "neutralMinionsKilledEnemyJungle": 1,
#             "assists": 3,
#             "magicDamageTaken": 5959,
#             "numDeaths": 8,
#             "totalTimeCrowdControlDealt": 256,
#             "largestMultiKill": 1,
#             "physicalDamageTaken": 16784,
#             "win": false,
#             "team": 100,
#             "totalDamageDealt": 63449,
#             "totalHeal": 9662,
#             "item3": 3191,
#             "item6": 3340,
#             "minionsKilled": 1,
#             "timePlayed": 1261,
#             "physicalDamageDealtToChampions": 52,
#             "championsKilled": 2,
#             "trueDamageTaken": 208,
#             "neutralMinionsKilled": 45,
#             "goldSpent": 4015
#          },
#          "gameId": 1874533003,
#          "ipEarned": 51,
#          "spell1": 4,
#          "teamId": 100,
#          "spell2": 11,
#          "gameMode": "CLASSIC",
#          "mapId": 11,
#          "level": 30,
#          "invalid": false,
#          "subType": "NORMAL",
#          "createDate": 1435886984028,
#          "championId": 9
#       },