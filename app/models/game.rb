class Game < ActiveRecord::Base
  enum status: [:safe, :check, :checkmate]

  has_many :pieces

  def board_state
    board = []
    pieces.each do |piece|
      board << [piece.x_coordinate, piece.y_coordinate]
    end
    board
  end
end
