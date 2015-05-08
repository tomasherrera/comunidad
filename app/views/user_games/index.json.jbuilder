json.current_owned_games @user_games.each_slice(6) do |slice|
  json.array! slice do |user_game|
    json.format user_game.format
    json.game user_game.game
  end
end

json.user_games_ids @user_games.map{|user_game| user_game.game.id}
