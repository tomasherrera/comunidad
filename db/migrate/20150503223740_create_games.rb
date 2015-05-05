class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.text :description
      t.string :juegos_score
      t.text :genre, array: true, default: []
      t.string :platform
      t.string :release_date
      t.string :small_cover
      t.string :large_cover

      t.timestamps
    end
  end
end
