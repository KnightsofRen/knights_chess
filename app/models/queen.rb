class Queen < Piece
  def obstructed?(destination_x, destination_y)
    return "Error: invalid input" if invalid_input?(self.x_coordinate,self.y_coordinate,destination_x,destination_y,'hvd')
    if (destination_x-self.x_coordinate).abs == (destination_y-self.y_coordinate).abs
      path = diagonal_path(self.x_coordinate,self.y_coordinate,destination_x,destination_y)
    else
      path = horizontal_and_vertical_path(self.x_coordinate,self.y_coordinate,destination_x,destination_y)
    end
    compare_to_board_state(path)
  end
end
