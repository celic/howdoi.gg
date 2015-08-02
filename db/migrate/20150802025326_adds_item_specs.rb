class AddsItemSpecs < ActiveRecord::Migration
    def change
          	add_column :items, :gold_value, :integer, default: 0 
    end
end
