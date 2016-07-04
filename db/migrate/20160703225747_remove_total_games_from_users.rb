class RemoveTotalGamesFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :total_games, :integer
  end
end
