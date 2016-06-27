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
    @piece.move_to!(params[:x_pos], params[:y_pos])
    redirect_to game_path(@game)
  end
end
