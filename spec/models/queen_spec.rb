require 'rails_helper'

RSpec.describe Queen, type: :model do
  describe 'valid_move' do
    it 'should return false if no position on board' do
      current_queen = FactoryGirl.create(:queen)
      expect(current_queen.position_on_board?(3, 8)).to eq(false)
    end

    it 'should return true for valid VERTICAL move' do
      current_queen = FactoryGirl.create(:queen)
      expect(current_queen.valid_move?(3, 5)).to eq(true)
    end

    it 'should return true for valid HORIZONTAL move' do
      current_queen = FactoryGirl.create(:queen)
      expect(current_queen.valid_move?(7, 0)).to eq(true)
    end

    it 'should return true for valid DIAGONAL move' do
      current_queen = FactoryGirl.create(:queen)
      expect(current_queen.valid_move?(2, 1)).to eq(true)
    end

    it 'should return true if DIAGONALLY obstructed' do
      game = FactoryGirl.create(:game)
      current_queen = FactoryGirl.create(:queen, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 1, y_coordinate: 2, game_id: game.id)
      expect(current_queen.obstructed?(0, 3)).to eq(true)
    end

    it 'should return true if HORIZONTALLY obstructed' do
      game = FactoryGirl.create(:game)
      current_queen = FactoryGirl.create(:queen, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 0, game_id: game.id)
      expect(current_queen.obstructed?(7, 0)).to eq(true)
    end

    it 'should return true if VERTICALLY obstructed' do
      game = FactoryGirl.create(:game)
      current_queen = FactoryGirl.create(:queen, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 3, y_coordinate: 4, game_id: game.id)
      expect(current_queen.obstructed?(3, 6)).to eq(true)
    end
  end
end
