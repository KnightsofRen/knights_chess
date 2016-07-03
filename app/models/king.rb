class King < Piece
  # valid moves--
  # king may move one square any direction
  # must NOT move onto square that is being attacked by opposing pieces
  # may capture piece IF where it's moving to there is no other piece protecting soon-to-be-captured piece(in-check)
  # because king may NOT move onto square that is being attacked 2 kings may NEVER stand next to each other => position: illegal

  def valid_move?(x, y)
    return false unless position_on_board?(x, y)
    return false if same_color_piece_present_at_target_destination?(x, y)
    return false if move_too_far?(x, y)
    true
  end

  private

  def position_on_board?(x, y)
    return false if x >= 8
    return false if x < 0
    return false if y < 0
    return false if y >= 8
    true
  end

  def move_too_far?(x, y)
    return true if (x_coordinate - x).abs > 1
    return true if (y_coordinate - y).abs > 1
    false
  end
end
