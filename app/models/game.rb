class Game < ActiveRecord::Base
  has_many :ownedgames
  has_many :game_comments

  def is_owned?(user_id)
    Ownedgame.where(:user_id => user_id, :game_id => self.id).length > 0
  end

  def owned_id(user_id)
    Ownedgame.find_by_user_id_and_game_id(user_id, self.id).id
  end
end
