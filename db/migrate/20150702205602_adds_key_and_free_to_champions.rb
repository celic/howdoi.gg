class AddsKeyAndFreeToChampions < ActiveRecord::Migration
  def change
  	add_column :champions, :key, :string
  	add_column :champions, :free, :boolean
  end
end
