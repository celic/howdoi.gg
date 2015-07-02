class AddsChampionTable < ActiveRecord::Migration
  def change
	create_table :champions do |t|
	  t.integer :riot_id
	  t.string :name
	  t.string :desc
	  t.timestamps
	end
  end
end
