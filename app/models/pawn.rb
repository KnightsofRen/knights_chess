class Pawn < Piece
  # First move, allowed to move 2
  # All moves allowed to move 1
  # Cant capture vertically
  # Up one, horizontal 1 to capture

  def valid_move?(x, y)
    return false if obstructed?(x, y) == 'Error'
    return false if same_color_piece_present_at_target_destination?(x, y)
    return true unless obstructed?(x, y) || !first_move?(x, y)
    return false if backward_sideway_or_over_one_move?(x, y)
    return false if piece_present_at_target_vertical_destination?(x, y)
    return false if piece_not_present_at_target_diagonal_destination?(x, y)
    true
  end

  private

  def backward_sideway_or_over_one_move?(_x, y)
    return false if color == 'white' && (y - y_coordinate) == 1
    return false if color == 'black' && (y - y_coordinate) == -1
    true
  end

  def piece_present_at_target_vertical_destination?(x, y)
    return true if x_coordinate == x && Game.find(game_id).pieces.find_by(x_coordinate: x, y_coordinate: y).present?
    false
  end

  def piece_not_present_at_target_diagonal_destination?(x, y)
    return true if x_coordinate != x && Game.find(game_id).pieces.find_by(x_coordinate: x, y_coordinate: y).nil?
    false
  end

  def first_move?(x, y)
    return false if piece_present_at_target_vertical_destination?(x, y)
    return true if color == 'white' && y == (y_coordinate + 2) && y_coordinate == 1 && x_coordinate == x
    return true if color == 'black' && y == (y_coordinate - 2) && y_coordinate == 6 && x_coordinate == x
    false
  end
end
