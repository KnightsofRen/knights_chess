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
    redirect_to game_path(current_game)
  end

  def destroy
    current_game.destroy
    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:name, :black_player_id)
  end

  helper_method :current_game
  def current_game
    @current_game = Game.find(params[:id])
  end
end
