require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'promote_pawn! method' do
    let(:game) { FactoryGirl.create(:game) }

    it 'should replace pawn with a new piece if piece can be promoted' do
      game.pieces.delete_all
      black_pawn = FactoryGirl.create(:pawn, x_coordinate: 4, y_coordinate: 1, color: 'black', game_id: game.id)
      white_pawn = FactoryGirl.create(:pawn, x_coordinate: 1, y_coordinate: 6, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 2, y_coordinate: 7, color: 'black', game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 0, game_id: game.id)
      expect(game.pieces.count).to eq 4

      expect(black_pawn.promote_pawn!(5, 0, 'Knight')).to eq 'Promoted'
      expect(game.pieces.count).to eq 3
      promoted_black_piece = game.pieces.find_by(x_coordinate: 5, y_coordinate: 0)
      expect(promoted_black_piece.type).to eq 'Knight'

      expect(white_pawn.promote_pawn!(2, 7, 'Rook')).to eq 'Promoted'
      expect(game.pieces.count).to eq 2
      promoted_white_piece = game.pieces.find_by(x_coordinate: 2, y_coordinate: 7)
      expect(promoted_white_piece.type).to eq 'Rook'
    end
    it 'should return error if piece is not able to be promoted' do
      queen = FactoryGirl.create(:queen, game_id: game.id)
      expect(queen.promote_pawn!(0, 7, 'Knight')).to eq 'Error'
    end
  end

  describe 'move_to! method' do
    let(:game) { FactoryGirl.create(:game) }

    it 'should capture if target piece has the opposite color as current piece' do
      current_piece = FactoryGirl.create(:piece, color: 0, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 4, y_coordinate: 4, color: 1, game_id: game.id)
      current_piece.move_to!(4, 4)

      expect(game.pieces.size).to eq(33)
    end

    it 'should update to the new_x, new_y coordinates (no piece at target)' do
      FactoryGirl.create(:piece, color: 0, game_id: game.id).move_to!(4, 4)
      expect(game.pieces.find_by(x_coordinate: 4, y_coordinate: 4)).to be_present
    end

    it 'should update to the new_x, new_y coordinates (piece at target)' do
      FactoryGirl.create(:piece, color: 0, game_id: game.id).move_to!(4, 4)
      FactoryGirl.create(:piece, x_coordinate: 4, y_coordinate: 4, color: 1, game_id: game.id)
      expect(game.pieces.find_by(x_coordinate: 4, y_coordinate: 4)).to be_present
    end
  end

  describe 'obstructed method' do
    let(:game) { FactoryGirl.create(:game) }
    let(:current_piece) { FactoryGirl.create(:piece, game_id: game.id) }

    it 'should return error if destination is same, out of bounds, or not hvd move' do
      expect(current_piece.obstructed?(3, 3)).to eq('Error')  # same as current location
      expect(current_piece.obstructed?(3, 8)).to eq('Error')  # out of bounds
      expect(current_piece.obstructed?(5, 4)).to eq('Error')  # not a valid hvd move
    end

    it 'should return true if there is an obstruction (horizontal)' do
      FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 3, game_id: game.id)
      expect(current_piece.obstructed?(6, 3)).to eq(true)
    end

    it 'should return true if there is an obstruction (vertical)' do
      FactoryGirl.create(:piece, x_coordinate: 3, y_coordinate: 4, game_id: game.id)
      expect(current_piece.obstructed?(3, 7)).to eq(true)
    end

    it 'should return true if there is an obstruction (diagonal)' do
      FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 1, game_id: game.id)
      expect(current_piece.obstructed?(6, 0)).to eq(true)
    end

    it 'should return false if there is no obstruction' do
      FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 4, game_id: game.id)
      expect(current_piece.obstructed?(3, 5)).to eq(false)
    end
  end

  describe 'putting_king_in_check?' do
    it 'returns TRUE or FALSE depending if piece is putting_king_in_check?' do
      game = FactoryGirl.create(:game)
      game.pieces.delete_all
      black_king = FactoryGirl.create(:king, x_coordinate: 1, y_coordinate: 7, color: 1, game_id: game.id)
      black_pawn = FactoryGirl.create(:pawn, x_coordinate: 2, y_coordinate: 6, color: 1, game_id: game.id)
      black_bishop = FactoryGirl.create(:bishop, x_coordinate: 4, y_coordinate: 7, color: 1, game_id: game.id)
      FactoryGirl.create(:pawn, x_coordinate: 0, y_coordinate: 6, color: 1, game_id: game.id)
      FactoryGirl.create(:pawn, x_coordinate: 1, y_coordinate: 6, color: 1, game_id: game.id)
      FactoryGirl.create(:rook, x_coordinate: 0, y_coordinate: 4, color: 1, game_id: game.id)
      FactoryGirl.create(:bishop, x_coordinate: 5, y_coordinate: 4, color: 0, game_id: game.id)
      FactoryGirl.create(:queen, x_coordinate: 6, y_coordinate: 2, color: 0, game_id: game.id)

      game.reload

      expect(black_king.putting_king_in_check?(2, 7)).to eq(true)
      expect(black_pawn.putting_king_in_check?(2, 5)).to eq(true)
      expect(black_bishop.putting_king_in_check?(3, 6)).to eq(false)
    end
  end
end
