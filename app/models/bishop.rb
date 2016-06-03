class Bishop < Piece
  def obstructed?(destination_x, destination_y)
    return "Error: invalid input" if invalid_input?(self.x_coordinate,self.y_coordinate,destination_x,destination_y,'d')
    path = diagonal_path(self.x_coordinate,self.y_coordinate,destination_x,destination_y)
    compare_to_board_state(path)
  end
end
