class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string  :name
      t.integer :player_white_id
      t.integer :player_black_id
      t.integer :status
      t.integer :winning_player_id
      t.timestamps
    end
  end
end
