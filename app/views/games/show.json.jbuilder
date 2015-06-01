json.game do
  json.id @game.id
  json.title @game.title
  json.description @game.description
  json.juegos_score @game.juegos_score
  json.genre @game.genre
  json.platform @game.platform
  json.release_date @game.release_date
  json.small_cover @game.small_cover
  json.large_cover @game.large_cover
  json.created_at @game.created_at
  json.updated_at @game.updated_at
  json.link @game.link
  json.developer @game.developer
  json.publisher @game.publisher
  json.players @game.players
  json.duration @game.duration
  json.language @game.language
  json.review_link @game.review_link
  json.game_type @game.game_type
  json.game_dlc @game.game_dlc
  json.game_dlc_id @game.game_dlc_id
  json.game_dlc_title @game_dlc.try(:title)
  json.owned @game.is_owned?(current_user.id)
  json.owned_id @game.owned_id(current_user.id) if @game.is_owned?(current_user.id)
end
