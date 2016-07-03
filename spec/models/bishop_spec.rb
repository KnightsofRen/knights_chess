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
      (-1..8).each do |y|
        (-1..8).each do |x|
          test += 1 if bishop.valid_move?(x, y) == true # => 7
        end
      end
      expect(test).to eq(7)
      expect(bishop.valid_move?(4, 4)).to eq false    # destination same as current position
      expect(bishop.valid_move?(8, 8)).to eq false    # off board
      expect(bishop.valid_move?(7, 4)).to eq false    # horizontal
      expect(bishop.valid_move?(4, 7)).to eq false    # vertical
      expect(bishop.valid_move?(2, 5)).to eq false    # not diagonal
      expect(bishop.valid_move?(6, 2)).to eq false    # obstructed
      expect(bishop.valid_move?(1, 1)).to eq false    # obstructed
      expect(bishop.valid_move?(2, 6)).to eq true     # valid
    end
  end
end
