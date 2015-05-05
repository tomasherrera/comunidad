class AddLinkToGames < ActiveRecord::Migration
  def change
    add_column :games, :link, :string
  end
end
