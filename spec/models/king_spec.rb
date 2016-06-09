require 'rails_helper'

RSpec.describe King, type: :model do
  describe 'valid_move' do
    it 'should return false if position on board is out of bounds' do
      current_king = FactoryGirl.create(:king)
      expect(current_king.position_on_board?(4, 8)).to eq(false)
    end

    it 'should return true if move too far' do
      current_king = FactoryGirl.create(:king)
      expect(current_king.move_too_far?(4, 3)).to eq(true)
    end

    it 'should return false if move into position under attack' do
      game = FactoryGirl.create(:game)
      current_king = FactoryGirl.create(:king, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 1, y_coordinate: 4, game_id: game.id)
      expect(current_king.move_into_position_under_attack?(4, 1)).to eq(false)
    end
  end
end
