class Game < ActiveRecord::Base
  has_many :user_games
end
