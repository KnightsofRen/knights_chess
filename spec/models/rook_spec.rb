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
      (-1..8).each do |y|
        (-1..8).each do |x|
          test += 1 if rook.valid_move?(x, y) == true # => 10
        end
      end
      expect(test).to eq(10)
      expect(rook.valid_move?(4, 4)).to eq false    # destination same as current position
      expect(rook.valid_move?(-3, 4)).to eq false   # off board
      expect(rook.valid_move?(6, 6)).to eq false    # diagonal
      expect(rook.valid_move?(3, 2)).to eq false    # not horizontal or vertical
      expect(rook.valid_move?(1, 4)).to eq false    # obstructed (horizontal)
      expect(rook.valid_move?(4, 1)).to eq false    # obstructed (vertical)
      expect(rook.valid_move?(4, 6)).to eq true     # valid
    end
  end
end
