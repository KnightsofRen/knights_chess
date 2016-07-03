class Piece < ActiveRecord::Base
  belongs_to :game

  enum color: [:white, :black]

  # (x, y) represents the target destination!

  def move_to!(x, y)
    destination_piece = game.pieces.find_by(x_coordinate: x, y_coordinate: y)
    destination_piece.delete if destination_piece.present?
    update_attributes(x_coordinate: x, y_coordinate: y)
  end

  def same_color_piece_present_at_target_destination?(x, y)
    destination_piece = game.pieces.find_by(x_coordinate: x, y_coordinate: y)
    if destination_piece.present?
      return true if destination_piece.color == color
    end
    false
  end

  def obstructed?(x, y)
    return 'Error' if invalid_input?(x_coordinate, y_coordinate, x, y)
    path = if (x - x_coordinate).abs == (y - y_coordinate).abs
             diagonal_path(x_coordinate, y_coordinate, x, y)
           else
             horizontal_and_vertical_path(x_coordinate, y_coordinate, x, y)
           end
    compare_to_board_state(path)
  end

  private

  def invalid_input?(x1, y1, x2, y2)
    current = [x1, y1]
    target = [x2, y2]
    # invalid if target destination same as current position
    return true if current == target
    # invalid if target destination out of range
    return true if !(0..7).cover?(target[0]) || !(0..7).cover?(target[1])
    # invalid if target is not a possible horizontal, vertical, or diagonal move
    return true if x2 != x1 && y2 != y1 && (x2 - x1).abs != (y2 - y1).abs
  end

  # rubocop:disable Metrics/AbcSize
  def diagonal_path(x1, y1, x2, y2)
    path = []
    # diagonal up, right; (+1, +1)
    if x2 > x1 && y2 > y1
      a = x1 + 1
      b = y1 + 1
      while a < x2
        path << [a, b]
        a += 1
        b += 1
      end
    # diagonal up, left; (-1, +1)
    elsif x2 < x1 && y2 > y1
      a = x1 - 1
      b = y1 + 1
      while a > x2
        path << [a, b]
        a -= 1
        b += 1
      end
    # diagonal down, right; (+1, -1)
    elsif x2 > x1 && y2 < y1
      a = x1 + 1
      b = y1 - 1
      while a < x2
        path << [a, b]
        a += 1
        b -= 1
      end
    # diagonal down, left; (-1, -1)
    elsif x2 < x1 && y2 < y1
      a = x1 - 1
      b = y1 - 1
      while a > x2
        path << [a, b]
        a -= 1
        b -= 1
      end
    end
    path
  end
  # rubocop:enable Metrics/AbcSize

  def horizontal_and_vertical_path(x1, y1, x2, y2)
    path = []
    # vertical up; (-, +1)
    if x2 == x1 && y2 > y1
      b = y1 + 1
      while b < y2
        path << [x2, b]
        b += 1
      end
    # vertical down; (-, -1)
    elsif x2 == x1 && y2 < y1
      b = y1 - 1
      while b > y2
        path << [x2, b]
        b -= 1
      end
    # horizontal left; (+1, -)
    elsif y2 == y1 && x2 > x1
      a = x1 + 1
      while a < x2
        path << [a, y2]
        a += 1
      end
    # horizontal right; (-1, -)
    elsif y2 == y1 && x2 < x1
      a = x1 - 1
      while a > x2
        path << [a, y2]
        a -= 1
      end
    end
    path
  end

  def compare_to_board_state(path)
    board = game.board_state
    (path & board).empty? ? false : true
  end
end
