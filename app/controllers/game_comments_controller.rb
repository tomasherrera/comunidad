class GameCommentsController < ApplicationController
  def index
    @game_comments = GameComment.where(game_id: params[:game_id]).includes(:user)
  end

  def create
    @game_comment = GameComment.create!(user_id: current_user.id, content: params[:content], game_id: params[:game_id])
    respond_to do |format|
      format.json
    end
  end
end
