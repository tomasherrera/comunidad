class CreateUserGames < ActiveRecord::Migration
  def change
    create_table :user_games do |t|
      t.references :game, index: true
      t.references :user, index: true
      t.string :format

      t.timestamps
    end
  end
end
