class PiecesController < ApplicationController
  include GamesHelper
  include PiecesHelper

  before_action :authenticate_user!, only: [:update]

  def show
    render text: valid_moves_array(params[:game_id], params[:id]).to_s
  end

  # rubocop:disable Metrics/AbcSize
  def update
    @game = Game.find(params[:game_id])
    @piece = @game.pieces.find(params[:id]) if @game.present?

    x = params[:x_pos].to_i
    y = params[:y_pos].to_i

    # check if current user is a player of game
    return render_not_found(:forbidden) if current_user.id != @game.player_white_id && current_user.id != @game.player_black_id

    # check if current user is correct color
    # !! currently disabled !!
    # return render_not_found(:forbidden) unless @piece.color == player_color

    # check turn logic
    return render_not_found(:forbidden) unless @game.turn == @piece.color

    # check valid moves
    return render_not_found(:forbidden) unless @piece.valid_move?(x, y)

    @piece.move_to!(x, y)
    render text: 'updated!'
  end
  # rubocop:enable Metrics/AbcSize

  private

  def player_color
    current_user.id == @game.player_white_id ? 'white' : 'black'
  end
end
