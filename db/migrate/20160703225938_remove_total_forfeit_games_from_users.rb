class RemoveTotalForfeitGamesFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :total_forfeit_games, :integer
  end
end
