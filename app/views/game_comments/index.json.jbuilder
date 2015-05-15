json.game_comments @game_comments.each do |comment|
  json.content comment.content
  json.user_first_name comment.user.first_name
  json.user_profile_pic comment.user.profile_picture
  json.created_at time_ago_in_words(comment.created_at, include_seconds: true)
end
