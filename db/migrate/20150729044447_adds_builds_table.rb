class AddsBuildsTable < ActiveRecord::Migration
    def change
        create_table :builds do |t|
            t.integer :champion_id
            t.integer :role
            t.integer :items, array: true, default: []
            t.integer :summoner_spells, array: true, default: []
        end
    end
end
