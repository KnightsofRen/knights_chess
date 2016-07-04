class PlayersController < ApplicationController
  require 'gchart'

  before_action :check_admin, only: [:index, :edit, :update, :delete_user]

  def index
    @users = User.all
    @games = Game.all
  end

  def show
    @user = User.find(params[:id])
    @games = Game.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to players_path
  end

  def delete_user
    User.find(params[:user_to_delete]).destroy
    redirect_to players_path
  end

  def change_nickname
    @user = User.find(current_user.id)
    @user.update_attributes(user_params)
    redirect_to player_path(@user)
  end

  private

  def check_admin
    return render_not_found(:forbidden) unless !current_user.nil? && current_user.admin?
  end

  def user_params
    params.require(:user).permit(
      :games_as_white, :won_games, :won_games_as_white, :lost_games, :lost_games_via_forfeit, :tied_games,
      :admin, :username
    )
  end
end
