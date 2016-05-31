class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :type
      t.string :color
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.boolean :captured
      
      t.timestamps
    end
  end
end
