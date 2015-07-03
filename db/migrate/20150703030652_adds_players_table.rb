class AddsPlayersTable < ActiveRecord::Migration
  def change
  	create_table :players do |t|
  	  t.string :name
  	  t.string :riot_id
  	end
  end
end
