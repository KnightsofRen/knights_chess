class PiecesController < ApplicationController
  include GamesHelper
  include PiecesHelper

  before_action :authenticate_user!, only: [:update]

  def show
    @game = Game.find_by_id(params[:game_id])
    @piece = @game.pieces.find_by_id(params[:id]) if @game.present?
    return render_not_found if @game.blank? || @piece.blank?
  end

  # rubocop:disable Metrics/AbcSize
  def update
    @game = Game.find_by_id(params[:game_id])
    @piece = @game.pieces.find_by_id(params[:id]) if @game.present?
    return render_not_found if @game.blank? || @piece.blank?
    return render_not_found(:forbidden) if current_user.id != @game.player_white_id && current_user.id != @game.player_black_id
    return render_not_found(:forbidden) unless @piece.color == player_color
    @piece.move_to!(params[:x_pos], params[:y_pos])
    redirect_to game_path(@game)
  end
  # rubocop:enable Metrics/AbcSize

  private

  def player_color
    current_user.id == @game.player_white_id ? 'white' : 'black'
  end
end
