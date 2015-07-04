# == Schema Information
#
# Table name: games
#
#  id        :integer          not null, primary key
#  blue_team :integer          default("{}"), is an Array
#  red_team  :integer          default("{}"), is an Array
#  winner    :boolean
#  time      :integer          default("0")
#  riot_id   :string
#

class Game < ActiveRecord::Base


	# Notes
		# blue_team is code 100
		# red_team is code 200
		# blue winning is winner = true
		# time stored in seconds only
end
