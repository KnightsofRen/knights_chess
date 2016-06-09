require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'obstructed method' do
    it 'should return invalid input if destination is same as current position' do
      current_piece = FactoryGirl.create(:piece)
      expect(current_piece.obstructed?(3, 3)).to eq('Error: invalid input')
    end

    it 'should return invalid input if destination is out of bounds' do
      current_piece = FactoryGirl.create(:piece)
      expect(current_piece.obstructed?(3, 8)).to eq('Error: invalid input')
    end

    it 'should return invalid input if destination is not a valid hvd move' do
      current_piece = FactoryGirl.create(:piece)
      expect(current_piece.obstructed?(5, 4)).to eq('Error: invalid input')
    end

    it 'should return true if there is an obstruction (horizontal)' do
      game = FactoryGirl.create(:game)
      current_piece = FactoryGirl.create(:piece, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 4, y_coordinate: 3, game_id: game.id)
      expect(current_piece.obstructed?(6, 3)).to eq(true)
    end

    it 'should return true if there is an obstruction (vertical)' do
      game = FactoryGirl.create(:game)
      current_piece = FactoryGirl.create(:piece, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 3, y_coordinate: 5, game_id: game.id)
      expect(current_piece.obstructed?(3, 7)).to eq(true)
    end

    it 'should return true if there is an obstruction (diagonal)' do
      game = FactoryGirl.create(:game)
      current_piece = FactoryGirl.create(:piece, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 1, game_id: game.id)
      expect(current_piece.obstructed?(6, 0)).to eq(true)
    end

    it 'should return false if there is no obstruction' do
      game = FactoryGirl.create(:game)
      current_piece = FactoryGirl.create(:piece, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 4, game_id: game.id)
      expect(current_piece.obstructed?(3, 5)).to eq(false)
    end
  end
end
