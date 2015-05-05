json.current_user_games @user_games.each_slice(4) do |slice|
  json.array! slice do |user_game|
    json.format user_game.format
    json.game user_game.game
  end
end
