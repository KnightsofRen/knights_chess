class Game < ActiveRecord::Base
  scope :available, -> { where('player_white_id IS NULL OR player_black_id IS NULL') }
  enum status: [:safe, :check, :checkmate, :forfeit]
  enum turn: [:white, :black, :off]

  belongs_to :user
  has_many :pieces

  after_create :populate_board!

  # def forfeit(current_player_id)
  #   if current_player_id == player_white_id
  #     update_attributes(winning_player_id: player_black_id, status: 'forfeit')
  #   else
  #     update_attributes(winning_player_id: player_white_id, status: 'forfeit')
  #   end
  # end

  def in_check?(king)
    king = pieces.find_by(type: 'King')
    pieces.each do |piece|
      return true if piece.valid_move?(king.x_coordinate, king.y_coordinate)
    end
    false
  end

  def stalemate?(king)
    # if king is not in check and unable to move to a safe square
    # the King is stalemated and game is drawn
    king = pieces.find_by(type: 'King')
    return false if in_check?(king) # king cannot be in check
    # binding.pry
    pieces.each do |piece|
      return false if piece.valid_move?(king.x_coordinate, king.y_coordinate) && !in_check?(king)
    end
    true # no valid moves, king not in_chcek stalemate!
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
        (0..7).each do |y|
          next unless piece.valid_move? # check every possible valid move
          piece.move_to!(x, y)
          # check to see if check is still true, waiting for check method
          false # return false if check becomes false
        end
      end
    end
    true # return true if no move could remove check
  end

  private

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
