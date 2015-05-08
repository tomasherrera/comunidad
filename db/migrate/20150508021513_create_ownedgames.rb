class CreateOwnedgames < ActiveRecord::Migration
  def change
    create_table :ownedgames do |t|
      t.references :game, index: true
      t.references :user, index: true
      t.string :formato

      t.timestamps
    end
  end
end
