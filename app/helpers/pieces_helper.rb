module PiecesHelper
  def tile_class(x, y, black_tile = true)
    if @piece.x_coordinate == x && @piece.y_coordinate == y
      black_tile == true ? 'black-tile-highlighted' : 'white-tile-highlighted'
    else
      black_tile == true ? 'black-tile' : 'white-tile'
    end
  end
end
