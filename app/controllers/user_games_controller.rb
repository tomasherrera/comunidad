class UserGamesController < ApplicationController
  def index

  end

  def show
  end

  def create
  end

  def update
  end

  def delete
  end

  def current_user_games
    @user_games = User.first.user_games.includes(:game)
    respond_to do |format|
      format.json
    end
  end
end
