class AddCastlingColumnsToGames < ActiveRecord::Migration
  def change
    add_column :games, :can_castle_w_ks, :integer
    add_column :games, :can_castle_w_qs, :integer
    add_column :games, :can_castle_b_ks, :integer
    add_column :games, :can_castle_b_qs, :integer
  end
end
