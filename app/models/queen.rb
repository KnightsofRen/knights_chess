class Queen < Piece
  def valid_move?(destination_x, destination_y)
    return false if obstructed?(destination_x, destination_y) == 'Error: invalid input'
    return false if obstructed?(destination_x, destination_y)
    true
  end
end
