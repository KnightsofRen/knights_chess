class Game < ActiveRecord::Base
  scope :available, -> { where('player_white_id IS NULL OR player_black_id IS NULL') }
  enum status: [:safe, :check, :checkmate]

  has_many :pieces

  after_create :populate_board!

  def populate_board!
    # !! board needs to be rearranged so that a white square is on bottom right (7, 7)
    # white pieces (bottom)
    # rook: [0,0],[7,0]; knight: [1,0],[6,0]; bishop: [2,0][5,0]; queen: [3,0]; king[4,0]
    # pawns: [0->7,1]
    # black pieces (top)
    # rook: [0,7],[7,7]; knight: [1,7],[6,7]; bishop: [2,7][5,7]; queen: [3,7]; king[4,7]
    # pawns: [0->7,7]
    create_non_pawn_pieces(id, 'white')
    create_non_pawn_pieces(id, 'black')
    create_pawn_pieces(id, 'white')
    create_pawn_pieces(id, 'black')
  end

  def board_state
    board = []
    pieces.each do |piece|
      board << [piece.x_coordinate, piece.y_coordinate]
    end
    board
  end

  private

  def create_non_pawn_pieces(id, color)
    non_pawn_pieces = [
      Rook.create(x_coordinate: 0), 
      Knight.create(x_coordinate: 1),
      Bishop.create(x_coordinate: 2),
      Queen.create(x_coordinate: 3),
      King.create(x_coordinate: 4),
      Bishop.create(x_coordinate: 5),
      Knight.create(x_coordinate: 6),
      Rook.create(x_coordinate: 7)
    ]
    if color == 'white'
      non_pawn_pieces.each do |piece|
        piece.update_attributes(y_coordinate: 0, game_id: id, color: color, captured: false)
      end
    elsif color == 'black'
      non_pawn_pieces.each do |piece|
        piece.update_attributes(y_coordinate: 7, game_id: id, color: color, captured: false)
      end
    end
  end

  def create_pawn_pieces(id, color)
    pawn_pieces = []
    for n in 0..7
      pawn_pieces << Pawn.create(x_coordinate: n)
    end
    if color == 'white'
      pawn_pieces.each do |piece|
        piece.update_attributes(y_coordinate: 1, game_id: id, color: color, captured: false)
      end
    elsif color == 'black'
      pawn_pieces.each do |piece|
        piece.update_attributes(y_coordinate: 6, game_id: id, color: color, captured: false)
      end
    end
  end

end
