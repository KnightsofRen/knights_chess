require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe 'valid_move?' do 
    it 'should return true if valid, false if invalid' do
      game = FactoryGirl.create(:game)
      game.pieces.delete_all
      # rook is at (4, 4), other pieces at (2, 4) and (4, 2)
      rook = FactoryGirl.create(:rook, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 2, y_coordinate: 4, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 4, y_coordinate: 2, game_id: game.id)
      test = 0
      test += 1 if rook.valid_move?(4,4) == false   # destination same as current position
      test += 1 if rook.valid_move?(-1,4) == false  # off board
      test += 1 if rook.valid_move?(6,6) == false   # diagonal
      test += 1 if rook.valid_move?(3,2) == false   # not horizontal or vertical
      test += 1 if rook.valid_move?(1,4) == false   # obstructed (horizontal)
      test += 1 if rook.valid_move?(4,1) == false   # obstructed (vertical)
      test += 1 if rook.valid_move?(4,6) == true    # valid
      expect(test).to eq(7)
    end
  end
end
