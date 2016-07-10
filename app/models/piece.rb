class Piece < ActiveRecord::Base
  belongs_to :game

  enum color: [:white, :black]

  # (x, y) represents the target destination!

  def move_to!(x, y)
    destination_piece = game.pieces.find_by(x_coordinate: x, y_coordinate: y)
    if type == 'King' && castle_move?(x, y)  
      update_castle_statuses(destination_piece)   
      castle!(x,y)
    else
      update_castle_statuses(destination_piece)   
      destination_piece.delete if destination_piece.present?
      update_attributes(x_coordinate: x, y_coordinate: y)
    end
    next_turn = game.turn == 'white' ? 'black' : 'white'
    game.update_attributes(turn: next_turn)
  end

  def update_castle_statuses(dp)
    game.update_attributes(can_castle_w_ks: 1) if type == 'Rook' && color == 'white' && x_coordinate == 7 && y_coordinate == 0
    game.update_attributes(can_castle_w_qs: 1) if type == 'Rook' && color == 'white' && x_coordinate == 0 && y_coordinate == 0
    game.update_attributes(can_castle_w_ks: 1, can_castle_w_qs: 1) if type == 'King' && color == 'white' && x_coordinate == 4 && y_coordinate == 0
    game.update_attributes(can_castle_b_ks: 1) if type == 'Rook' && color == 'black' && x_coordinate == 7 && y_coordinate == 7
    game.update_attributes(can_castle_b_qs: 1) if type == 'Rook' && color == 'black' && x_coordinate == 0 && y_coordinate == 7
    game.update_attributes(can_castle_b_ks: 1, can_castle_b_qs: 1) if type == 'King' && color == 'black' && x_coordinate == 4 && y_coordinate == 7

    if dp.present?
      game.update_attributes(can_castle_w_ks: 1) if dp.type == 'Rook' && dp.color == 'white' && dp.x_coordinate == 7 && dp.y_coordinate == 0
      game.update_attributes(can_castle_w_qs: 1) if dp.type == 'Rook' && dp.color == 'white' && dp.x_coordinate == 0 && dp.y_coordinate == 0
      game.update_attributes(can_castle_b_ks: 1) if dp.type == 'Rook' && dp.color == 'black' && dp.x_coordinate == 7 && dp.y_coordinate == 7
      game.update_attributes(can_castle_b_qs: 1) if dp.type == 'Rook' && dp.color == 'black' && dp.x_coordinate == 0 && dp.y_coordinate == 7
    end
  end

  def castle!(x,y)
    update_attributes(x_coordinate: x, y_coordinate: y)
    # white king, king side castling
    if color == 'white' && x > 4
      game.pieces.find_by(x_coordinate: 7, y_coordinate: 0).update_attributes(x_coordinate: 5)
    end
    # white king, queen side castling
    if color == 'white' && x < 4
      game.pieces.find_by(x_coordinate: 0, y_coordinate: 0).update_attributes(x_coordinate: 3)
    end
    # black king, king side castling
    if color == 'black' && x > 4
      game.pieces.find_by(x_coordinate: 7, y_coordinate: 7).update_attributes(x_coordinate: 5)
    end
    # black king, queen side castling
    if color == 'black' && x < 4 
      game.pieces.find_by(x_coordinate: 0, y_coordinate: 7).update_attributes(x_coordinate: 3)
    end
  end

  def promote_pawn!(x, y, choice = 'Queen')
    # check if piece is white pawn moving to top row (y = 7) or black pawn moving to bottom row (y = 0)
    if (type == 'Pawn' && color == 'white' && y == 7) || (type == 'Pawn' && color == 'black' && y == 0)
      move_to!(x, y)
      update_attributes(type: choice)
      'Promoted'
    else
      'Error'
    end
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

  def putting_king_in_check?(x, y)
    # org coordinates to retract to if necessary
    current_x_pos = x_coordinate
    current_y_pos = y_coordinate

    # temp piece coordinates updated with destination coordinates to check if move would cause chck
    update_attributes x_coordinate: x, y_coordinate: y

    king = game.pieces.find_by(type: 'King')
    game.pieces.each do |piece|
      return true if piece.valid_move?(king.x_coordinate, king.y_coordinate)
    end

    update_attributes x_coordinate: current_x_pos, y_coordinate: current_y_pos
    # if king would not 'put in check', piece coordinates revert for move
    false
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
