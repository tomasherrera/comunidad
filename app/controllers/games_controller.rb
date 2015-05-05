class GamesController < ApplicationController

  def index
    @games = Game.all
    respond_to do |format|
      format.json
    end
  end
end
