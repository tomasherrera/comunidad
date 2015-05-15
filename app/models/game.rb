class Game < ActiveRecord::Base
  has_many :ownedgames
  has_many :game_comments
end
