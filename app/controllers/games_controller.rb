class GamesController < ApplicationController
  include GamesHelper

  before_action :authenticate_user!, only: [:new, :create]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    params[:game][:status] = 'safe'
    if params[:color].to_i == 1
      params[:game][:player_white_id] = current_user.id
      @game = Game.create(game_params)
    else
      params[:game][:player_black_id] = current_user.id
      @game = Game.create(game_params)
    end
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

  # def forfeit
  #   current_game.forfeit(current_user.id)
  #   redirect_to game_path(current_game)
  # end

  def current_game
    @current_game = Game.find(params[:id])
  end
  helper_method :current_game

  private

  def game_params
    params.require(:game).permit(:name, :player_black_id, :player_white_id, :status)
  end
end
