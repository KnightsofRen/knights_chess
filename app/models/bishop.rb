class Bishop < Piece
  def valid_move?(x, y)
    return false if obstructed?(x, y) == 'Error'
    return false if same_color_piece_present_at_target_destination?(x, y)
    return false if x == x_coordinate || y == y_coordinate
    return false if obstructed?(x, y)
    true
  end
end
