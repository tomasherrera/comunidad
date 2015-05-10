class AddGameDlcIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :game_dlc_id, :integer
  end
end
