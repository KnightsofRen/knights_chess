require 'rails_helper'

RSpec.describe King, type: :model do
  describe 'valid_move' do
    it 'should return false valid move if no position on board' do
      current_king = FactoryGirl.create(:king)
      expect(current_king.valid_move?(4, 8)).to eq(false)
    end

    it 'should return true valid move if position is on board' do
      current_king = FactoryGirl.create(:king)
      expect(current_king.valid_move?(4, 1)).to eq(true)
    end

    it 'should return false valid move if move too far' do
      current_king = FactoryGirl.create(:king)
      expect(current_king.valid_move?(4, 3)).to eq(false)
    end

    it 'should return true valid move if move is not too far' do
      current_king = FactoryGirl.create(:king)
      expect(current_king.valid_move?(5, 0)).to eq(true)
    end

    it 'should return true valid move if move into position NOT under attack' do
      game = FactoryGirl.create(:game)
      current_king = FactoryGirl.create(:king, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 3, y_coordinate: 3, game_id: game.id)
      expect(current_king.valid_move?(4, 1)).to eq(true)
    end

    it 'should return true valid move if move into position under attack' do
      game = FactoryGirl.create(:game)
      current_king = FactoryGirl.create(:king, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 3, y_coordinate: 3, game_id: game.id)
      expect(current_king.valid_move?(4, 2)).to eq(false)
    end
  end
end
