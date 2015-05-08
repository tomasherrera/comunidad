json.current_owned_games @ownedgames.each_slice(6) do |slice|
  json.array! slice do |ownedgame|
    json.id ownedgame.id
    json.formato ownedgame.formato
    json.game ownedgame.game
  end
end

json.ownedgames_ids @ownedgames.map{|ownedgame| ownedgame.game.id}
