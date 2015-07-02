class AddsPatchTable < ActiveRecord::Migration
  def change
  	  create_table :patches do |t|
		t.string :number
		t.timestamps
    end
  end
end
