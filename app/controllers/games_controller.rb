class GamesController < ApplicationController
  layout false
  respond_to :json

  def index
    @games = Game.all
    respond_to do |format|
      format.json
    end
  end

  def show
    @game = Game.find(params[:id])
    @game_dlc = Game.find(@game.game_dlc_id) unless @game.game_dlc_id.nil?
    respond_to do |format|
      format.json
    end
  end
end
