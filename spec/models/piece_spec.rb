require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'obstructed method' do
    let(:game) { FactoryGirl.create(:game) }
    let(:current_piece) { FactoryGirl.create(:piece, game_id: game.id) }

    it 'should return invalid input if destination is same as current position' do
      expect(current_piece.obstructed?(3, 3)).to eq('Error: invalid input')
    end

    it 'should return invalid input if destination is out of bounds' do
      expect(current_piece.obstructed?(3, 8)).to eq('Error: invalid input')
    end

    it 'should return invalid input if destination is not a valid hvd move' do
      expect(current_piece.obstructed?(5, 4)).to eq('Error: invalid input')
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
