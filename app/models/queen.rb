class Queen < Piece
  # queen may move any direction any # of spaces unless out of bounds
  # can be blocked -- obstructed method inherited 4rm Piece
  def valid_move?(x, y)
    x_coordinate == x || y_coordinate == y || (x_coordinate - x).abs == (y_coordinate - y).abs
  end

  def position_on_board?(x, y)
    return false if x >= 8
    return false if x < 0
    return false if y < 0
    return false if y >= 8
    true
  end
end
