class GamesController < ApplicationController
  include GamesHelper

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @games = Game.all
  end

  def forfeit
    return render_not_found(:forbidden) if current_user.id != current_game.player_white_id && current_user.id != current_game.player_black_id
    return render_not_found(:forbidden) if game_is_open
    current_game.forfeit(current_user.id)
    render text: "Game forfeit by #{current_user.username} --  #{User.find(current_game.winning_player_id).username} wins!"
    # redirect_to game_path(current_game)
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
    return render_not_found if current_game.blank?
  end

  def edit
    return render_not_found(:forbidden) if current_user.id != current_game.user_id
  end

  # to join game as another user, or update game name if user created game
  # rubocop:disable Metrics/AbcSize
  def update
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
      return render_not_found(:forbidden)
    end
  end
  # rubocop:enable Metrics/AbcSize

  def destroy
    if !current_user.nil? && current_user.admin?
      current_game.destroy
      redirect_to players_path
    else
      return render_not_found(:forbidden) if current_user.id != current_game.user_id
      return render_not_found(:forbidden) unless game_is_open
      current_game.destroy
      redirect_to player_path(current_user)
    end
  end

  private

  def current_game
    @current_game = Game.find(params[:id])
  end
  helper_method :current_game

  def game_params
    params.require(:game).permit(:name, :player_black_id, :player_white_id, :status, :user_id, :turn)
  end

  def game_is_open
    current_game.player_white_id.nil? || current_game.player_black_id.nil?
  end
end
