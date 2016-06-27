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
    if params[:color].to_i == 1
      params[:game][:player_white_id] = current_user.id
    else
      params[:game][:player_black_id] = current_user.id
    end
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
  end

  def edit
  end

  def update
    if user_signed_in? && current_user.id != current_game.user_id
      current_game.update_attributes(game_params)
      flash.notice = 'You have successfully joined the game!'
      redirect_to game_path(current_game)
    elsif user_signed_in?
      flash.alert = 'You are the host of this game!'
      redirect_to root_path
    else
      flash.alert = 'You must be signed in to join games!'
      redirect_to root_path
    end
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
    params.require(:game).permit(:name, :player_black_id, :player_white_id, :status, :user_id, :turn)
  end
end
