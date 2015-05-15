class CreateGameComments < ActiveRecord::Migration
  def change
    create_table :game_comments do |t|
      t.references :user, index: true
      t.references :game, index: true
      t.text :content
      t.integer :likes
      t.integer :dislikes
      t.integer :flags

      t.timestamps
    end
  end
end
