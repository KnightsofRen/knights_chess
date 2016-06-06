class AddGameIdColumnToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :game_id, :integer
  end
end
