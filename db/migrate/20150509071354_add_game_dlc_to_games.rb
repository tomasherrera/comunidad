class AddGameDlcToGames < ActiveRecord::Migration
  def change
    add_column :games, :game_dlc, :string
  end
end
