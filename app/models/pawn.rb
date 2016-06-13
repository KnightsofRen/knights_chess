class Pawn < Piece
  # First move, allowed to move 2
  # All moves allowed to move 1
  # Cant capture vertically
  # Up one, horizontal 1 to capture

  def valid_move?(x, y)
    return false if move_backwards?(x, y)
    return false if first_move?(x, y)
    return false if allowed?(x, y)
    return false unless position_on_board?(x, y)
    true
  end

  private

  def move_backwards?(_x, y)
    # cannot move backwards
    return false if (y_coordinate - y) < 0
    true
  end

  def first_move?(x, y)
    # initial spot 0,1 => 0,2 0,3
    # can move 2 spaces first move
    return true if y == (y_coordinate + 2) && y_coordinate == 2 && x_coordinate == x
    false
  end

  def allowed?(x, y)
    return true if x_coordinate == x && y_coordinate - y == 1
    false
  end

  def position_on_board?(x, y)
    return false if x >= 8
    return false if x < 0
    return false if y < 0
    return false if y >= 8
    true
  end
end
