class UserGamesController < ApplicationController
  respond_to :json

  def index
    @user_games = current_user.user_games.includes(:game)
    respond_to do |format|
      format.json
    end
  end

  def show
  end

  def create
    @user_game = UserGame.create!(:game_id => params[:user_game][:game_id], :format => params[:user_game][:format], :user_id => current_user.id )
    respond_to do |format|
      format.json
    end
  end

  def update
  end

  def destroy
    puts "*" * 100
    p params
    user_game = UserGame.find(params[:id])
    if(user_game.destroy)
			render json: user_game, status: :ok
    end
  end

  private

	def user_games_params
		params.require(:user_game).permit(:game_id, :user_id, :format)
	end
end
