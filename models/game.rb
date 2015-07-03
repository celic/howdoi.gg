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

end
