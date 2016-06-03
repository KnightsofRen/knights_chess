class Piece < ActiveRecord::Base
  enum color: [:black, :white]
  belongs_to :game

  def invalid_input?(x1,y1,x2,y2,move)
    current = [x1, y1]
    target = [x2, y2]
    #invalid if target destination same as current position
    return true if current == target 
    #invalid if target destination out of range
    return true if !(0..7).include?(target[0]) || !(0..7).include?(target[1])
    #invalid if target is not a possible horizontal or vertical move (rook)
    if move == 'hv'
      return true if x2 != x1 && y2 != y1
    #invalid it target is not a possible diagonal move (bishop)
    elsif move == 'd'
      return true if (x2-x1).abs != (y2-y1).abs
    #invalid if target is not a possible hvd move (queen)
    elsif move == 'hvd'
      return true if x2 != x1 && y2 != y1 && (x2-x1).abs != (y2-y1).abs
    end
  end

  def diagonal_path(x1,y1,x2,y2)
    path = []
    #diagonal up, right; (+1, +1)
    if x2 > x1 && y2 > y1 
      a = x1+1
      b = y1+1
      while a < x2
        path << [a, b]
        a += 1
        b += 1 
      end
    #diagonal up, left; (-1, +1)
    elsif x2 < x1 && y2 > y1 
      a = x1-1
      b = y1+1
      while a > x2
        path << [a, b]
        a -= 1
        b += 1 
      end
    #diagonal down, right; (+1, -1) 
    elsif x2 > x1 && y2 < y1 
      a = x1+1
      b = y1-1
      while a < x2
        path << [a, b]
        a += 1
        b -= 1 
      end
    #diagonal down, left; (-1, -1)
    elsif x2 < x1 && y2 < y1 
      a = x1-1
      b = y1-1
      while a > x2
        path << [a, b]
        a -= 1
        b -= 1 
      end
    end
    return path
  end

  def horizontal_and_vertical_path(x1,y1,x2,y2)
    path = []
    #vertical up; (-, +1)
    if x2 == x1 && y2 > y1
      b = y1+1
      while b < y2
        path << [x2, b]
        b += 1 
      end
    #vertical down; (-, -1)
    elsif x2 == x1 && y2 < y1
      b = y1-1 
      while b > y2
        path << [x2, b]
        b -= 1
      end
    #horizontal left; (+1, -)
    elsif y2 == y1 && x2 > x1
      a = x1+1 
      while a < x2
        path << [a, y2]
        a += 1
      end
    #horizontal right; (-1, -)
    elsif y2 == y1 && x2 < x1
       a = x1-1 
      while a > x2
        path << [a, y2]
        a -= 1
      end
    end
    return path
  end

  def compare_to_board_state(path)
    board = Game.board_state
    (path & board).length > 0 ? true : false
  end
end
