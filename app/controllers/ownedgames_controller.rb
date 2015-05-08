class OwnedgamesController < ApplicationController
  respond_to :json

  def index
    @ownedgames = current_user.ownedgames.includes(:game)
    respond_to do |format|
      format.json
    end
  end

  def show
  end

  def create
    @ownedgame = Ownedgame.create!(:game_id => params[:ownedgame][:game_id], :formato => params[:ownedgame][:formato], :user_id => current_user.id )
    respond_to do |format|
      format.json
    end
  end

  def update
  end

  def destroy
    ownedgame = Ownedgame.find(params[:id])
    if(ownedgame.destroy)
			render json: ownedgame, status: :ok
    end
  end

end
