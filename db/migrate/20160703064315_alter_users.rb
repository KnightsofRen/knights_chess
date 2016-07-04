class AlterUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_games, :integer
    add_column :users, :games_as_white, :integer
    add_column :users, :won_games, :integer
    add_column :users, :won_games_as_white, :integer
    add_column :users, :lost_games, :integer
    add_column :users, :total_forfeit_games, :integer
    add_column :users, :lost_games_via_forfeit, :integer
    add_column :users, :tied_games, :integer
  end
end
