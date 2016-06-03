class Game < ActiveRecord::Base
  enum status: [:safe, :check, :checkmate]

  def self.board_state
    board = []
    Piece.all.each do |piece|
      board << [piece.x_coordinate, piece.y_coordinate]
    end
    return board
  end

end
