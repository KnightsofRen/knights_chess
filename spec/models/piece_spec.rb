require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'move_to! method' do
    let(:game) { FactoryGirl.create(:game) }
    it 'should return error if target piece has same color as current piece' do
      current_piece = FactoryGirl.create(:piece, color: 0, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 4, y_coordinate: 4, color: 0, game_id: game.id)
      expect(current_piece.move_to!(4, 4)).to eq('Error')
    end

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
end
