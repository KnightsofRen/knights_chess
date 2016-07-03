class PiecesController < ApplicationController
  include GamesHelper
  include PiecesHelper

  def show
    @game = Game.find(params[:game_id])
    @piece = @game.pieces.find(params[:id])
  end

  def update
    @game = Game.find(params[:game_id])
    @piece = @game.pieces.find(params[:id])
    @piece.update_attributes(piece_params)
    redirect_to game_path(@game)
  end

  private

  def piece_params
    params.require(:piece).permit(:x_coordinate, :y_coordinate)
  end
end
