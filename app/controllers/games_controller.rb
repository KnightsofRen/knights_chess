class GamesController < ApplicationController
  include GamesHelper

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
    return render text: 'Game Not Found!', status: :not_found if current_game.blank?
  end

  def edit
    return render text: 'Game Not Found!', status: :not_found if current_game.blank?
    return render text: 'Forbidden!', status: :forbidden if current_user.id != current_game.user_id
  end

  # to join game as another user, or update game name if user created game
  # rubocop:disable Metrics/AbcSize
  def update
    return render text: 'Game Not Found!', status: :not_found if current_game.blank?
    if current_user.id != current_game.user_id && game_is_open
      current_game.update_attributes(game_params)
      flash.notice = 'You have successfully joined the game!'
      redirect_to game_path(current_game)
    elsif current_user.id == current_game.user_id
      if params[:on_edit_page] == 'yes'
        current_game.update_attributes(game_params)
        flash.notice = 'Game name changed!'
        redirect_to game_path(current_game)
      else
        flash.alert = 'You are the host of this game!'
        redirect_to root_path
      end
    else
      return render text: 'Forbidden!', status: :forbidden
    end
  end
  # rubocop:enable Metrics/AbcSize

  def destroy
    return render text: 'Game Not Found!', status: :not_found if current_game.blank?
    return render text: 'Forbidden!', status: :forbidden if current_user.id != current_game.user_id
    current_game.destroy
    redirect_to root_path
  end

  # def forfeit
  #   current_game.forfeit(current_user.id)
  #   redirect_to game_path(current_game)
  # end

  def current_game
    @current_game = Game.find_by_id(params[:id])
  end
  helper_method :current_game

  private

  def game_params
    params.require(:game).permit(:name, :player_black_id, :player_white_id, :status, :user_id, :turn)
  end

  def game_is_open
    current_game.player_white_id.nil? || current_game.player_black_id.nil?
  end
end
