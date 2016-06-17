module PiecesHelper
  def tile_class(x, y, black_tile = true)
    # return highlight-dark tile if piece is at that tile
    # return highlight-light tile if that tile is valid move
    if @piece.x_coordinate == x && @piece.y_coordinate == y
      black_tile == true ? 'black-tile highlight-dark' : 'white-tile highlight-dark'
    elsif @piece.valid_move?(x, y)
      black_tile == true ? 'black-tile highlight-light' : 'white-tile highlight-light'
    else
      black_tile == true ? 'black-tile' : 'white-tile'
    end
  end
end
