module GamesHelper
  # rubocop:disable Metrics/AbcSize
  def render_piece(x, y)
    piece = Game.find(current_game.id).pieces.find { |p| p.x_coordinate == x && p.y_coordinate == y }
    choice = piece.type.to_s unless piece.nil?

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
      piece.white? ? white_rook.to_s : black_rook.to_s
    when 'Knight'
      piece.white? ? white_knight.to_s : black_knight.to_s
    when 'Bishop'
      piece.white? ? white_bishop.to_s : black_bishop.to_s
    when 'Queen'
      piece.white? ? white_queen.to_s : black_queen.to_s
    when 'King'
      piece.white? ? white_king.to_s : black_king.to_s
    when 'Pawn'
      piece.white? ? white_pawn.to_s : black_pawn.to_s
    end
  end
  # rubocop:enable Metrics/AbcSize
end
