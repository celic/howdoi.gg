class AddsGamesTable < ActiveRecord::Migration
  def change
  	create_table :games do |t|
  	  t.integer :blue_team, array: true, default: []
  	  t.integer :red_team, array: true, default: []
  	  t.boolean :winner
  	  t.integer :time, default: 0
  	end
  end
end
