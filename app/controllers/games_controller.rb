class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to root_path
  end

  def show
  end

  def edit
  end

  def update
    current_game.update_attributes(game_params)
    redirect_to root_path
  end

  def destroy
    current_game.destroy
    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:name, :black_player_id)
  end

  helper_method :current_game, :add_player
  def current_game
    @current_game = Game.find(params[:id])
  end
  
  def add_player(game)
    game.update(player_black_id: current_user)
    game_path(game)
  end
end
