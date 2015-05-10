class AddDetailsToGames < ActiveRecord::Migration
  def change
    add_column :games, :developer, :string
    add_column :games, :publisher, :string
    add_column :games, :players, :string
    add_column :games, :duration, :string
    add_column :games, :language, :string
    add_column :games, :review_link, :string
  end
end
