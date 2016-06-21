class Rook < Piece
  def valid_move?(x, y)
    return false if obstructed?(x, y) == 'Error'
    return false if same_color_piece_present_at_target_destination?(x, y)
    return false if (x - x_coordinate).abs == (y - y_coordinate).abs
    return false if obstructed?(x, y)
    true
  end
end
