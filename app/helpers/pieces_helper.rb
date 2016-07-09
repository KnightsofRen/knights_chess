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

  # returns array of piece present location and all possible valid moves (if any)
  def valid_moves_array(game_id, id)
    piece = Game.find(game_id).pieces.find_by(id: id)
    valid_moves_array = []
    if piece.present? && piece.color == Game.find(game_id).turn
      valid_moves_array = [[piece.x_coordinate, piece.y_coordinate]]
      (0..7).each do |y_target|
        (0..7).each do |x_target|
          valid_moves_array << [x_target, y_target] if piece.valid_move?(x_target, y_target)
        end
      end
      valid_moves_array
    end
  end
end
