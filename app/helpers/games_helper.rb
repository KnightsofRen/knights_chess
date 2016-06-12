module GamesHelper
  # rubocop:disable Metrics/AbcSize
  def render_piece(x, y)
    piece = current_game.pieces.find_by(x_coordinate: x, y_coordinate: y)
    choice = piece.type unless piece.nil?

    # https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    white_king = "\u2654".encode('utf-8')
    white_queen = "\u2655".encode('utf-8')
    white_rook = "\u2656".encode('utf-8')
    white_bishop = "\u2657".encode('utf-8')
    white_knight = "\u2658".encode('utf-8')
    white_pawn = "\u2659".encode('utf-8')
    black_king = "\u265A".encode('utf-8')
    black_queen = "\u265B".encode('utf-8')
    black_rook = "\u265C".encode('utf-8')
    black_bishop = "\u265D".encode('utf-8')
    black_knight = "\u265E".encode('utf-8')
    black_pawn = "\u265F".encode('utf-8')

    case choice
    when 'Rook'
      piece.white? ? white_rook : black_rook
    when 'Knight'
      piece.white? ? white_knight : black_knight
    when 'Bishop'
      piece.white? ? white_bishop : black_bishop
    when 'Queen'
      piece.white? ? white_queen : black_queen
    when 'King'
      piece.white? ? white_king : black_king
    when 'Pawn'
      piece.white? ? white_pawn : black_pawn
    end
  end
  # rubocop:enable Metrics/AbcSize
end
