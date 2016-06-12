require 'rails_helper'

RSpec.describe Bishop, type: :model do
  describe 'valid_move?' do
    it 'should return true if valid, false if invalid' do
      game = FactoryGirl.create(:game)
      game.pieces.delete_all
      # bishop is at (4, 4), other pieces at (2, 2) and (5, 3)
      bishop = FactoryGirl.create(:bishop, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 2, y_coordinate: 2, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 3, game_id: game.id)
      test = 0
      test += 1 if bishop.valid_move?(4, 4) == false     # destination same as current position
      test += 1 if bishop.valid_move?(8, 8) == false     # off board
      test += 1 if bishop.valid_move?(7, 4) == false     # horizontal
      test += 1 if bishop.valid_move?(4, 7) == false     # vertical
      test += 1 if bishop.valid_move?(2, 5) == false     # not diagonal
      test += 1 if bishop.valid_move?(6, 2) == false     # obstructed
      test += 1 if bishop.valid_move?(1, 1) == false     # obstructed
      test += 1 if bishop.valid_move?(2, 6) == true      # valid
      expect(test).to eq(8)
    end
  end
end
