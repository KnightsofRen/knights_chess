class GamesController < ApplicationController
  include GamesHelper

  def index
    @games = Game.all
  end

  def forfeit
    current_game.forfeit(current_user.id)
    redirect_to game_path(current_game)
  end
  
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
  end

  def edit
  end

  def update
    current_game.update_attributes(game_params)
    redirect_to game_path(current_game)
  end

  def destroy
    current_game.destroy
    redirect_to root_path
  end


#<<<<<<< HEAD

#<<<<<<< HEAD

#=======
  def current_game
    @current_game = Game.find(params[:id])
  end
  helper_method :current_game
#>>>>>>> fd6eb585143134412c1b655eb9cf2c09ded708d5

  private

  def game_params
    params.require(:game).permit(:name, :player_black_id, :player_white_id)
  end
end
