class Game < ActiveRecord::Base
  scope :available, -> { where('player_white_id IS NULL OR player_black_id IS NULL') }
  enum status: [:safe, :check, :checkmate]

  has_many :pieces

  after_create :populate_board!

  def populate_board!
    # WHITE pieces (bottom)
    # rook: [0,0],[7,0]; knight: [1,0],[6,0]; bishop: [2,0][5,0]; queen: [3,0]; king[4,0]
    # pawns: [0->7,1]
    # BLACK pieces (top)
    # rook: [0,7],[7,7]; knight: [1,7],[6,7]; bishop: [2,7][5,7]; queen: [3,7]; king[4,7]
    # pawns: [0->7,6]
    # white: 0, black: 1
    create_non_pawn_pieces(0)
    create_non_pawn_pieces(1)
    create_pawn_pieces(0)
    create_pawn_pieces(1)
  end

  def board_state
    board = []
    pieces.each do |piece|
      board << [piece.x_coordinate, piece.y_coordinate]
    end
    board
  end
  
  def checkmate?
    pieces.each do |piece| 
      (0..7).each do |x|
        (0.7).each do |y|
          piece.move_to!(x,y)
          #check to see if check is still true, waiting for check method
          false #return false if check becomes false
        end
      end
    end
    true #return true if no move could remove check
  end

  private

  def create_non_pawn_pieces(color)
    non_pawn_pieces = [
      pieces.new(x_coordinate: 0, type: 'Rook'),
      pieces.new(x_coordinate: 1, type: 'Knight'),
      pieces.new(x_coordinate: 2, type: 'Bishop'),
      pieces.new(x_coordinate: 3, type: 'Queen'),
      pieces.new(x_coordinate: 4, type: 'King'),
      pieces.new(x_coordinate: 5, type: 'Bishop'),
      pieces.new(x_coordinate: 6, type: 'Knight'),
      pieces.new(x_coordinate: 7, type: 'Rook')
    ]
    if color == 0
      non_pawn_pieces.each do |piece|
        piece.update_attributes(y_coordinate: 0, color: color, captured: false)
      end
    elsif color == 1
      non_pawn_pieces.each do |piece|
        piece.update_attributes(y_coordinate: 7, color: color, captured: false)
      end
    end
  end

  def create_pawn_pieces(color)
    pawn_pieces = []
    (0..7).each do |n|
      pawn_pieces << pieces.new(x_coordinate: n, type: 'Pawn')
    end
    if color == 0
      pawn_pieces.each do |piece|
        piece.update_attributes(y_coordinate: 1, color: color, captured: false)
      end
    elsif color == 1
      pawn_pieces.each do |piece|
        piece.update_attributes(y_coordinate: 6, color: color, captured: false)
      end
    end
  end
end
