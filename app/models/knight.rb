class Knight < Piece
  def valid_move?(destination_x, destination_y)
    # no obstructions, just check that destination (x, y) is on board and valid
    # http://imgur.com/B1MmsHw
    # 8 possible moves from current (x, y)
    # (-1, +2), (-2, +1)  top left
    # (-1, -2), (-2, -1)  bottom left
    # (+1, +2), (+2. +1)  top right
    # (+1, -2), (+2, -1)  bottom right
    # invalid if (destination x - x).abs not equal 1 or 2
    # if 1, then (destination y - x).abs must be 2 to be valid
    # if 2, then " " must be 1 " "
    x_diff = (destination_x - x_coordinate).abs
    y_diff = (destination_y - y_coordinate).abs
    return false if !(0..7).cover?(destination_x) || !(0..7).cover?(destination_y)
    return true if (x_diff == 1 && y_diff == 2) || (x_diff == 2 && y_diff == 1)
    false
  end
end
