class Game < ActiveRecord::Base
  scope :available, -> { where('player_white_id IS NULL OR player_black_id IS NULL') }
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
