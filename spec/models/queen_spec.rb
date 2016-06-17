require 'rails_helper'

RSpec.describe Queen, type: :model do
  describe 'valid_move?' do
    it 'should return true if valid, false if invalid' do
      game = FactoryGirl.create(:game)
      game.pieces.delete_all
      # queen is at (4, 4), other pieces at (1, 4), (4, 5), (2,2)
      queen = FactoryGirl.create(:queen, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 1, y_coordinate: 4, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 4, y_coordinate: 5, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 2, y_coordinate: 2, game_id: game.id)
      test = 0
      (-1..8).each do |y|
        (-1..8).each do |x|
          test += 1 if queen.valid_move?(x, y) == true # => 22
        end
      end
      expect(test).to eq(22)
      expect(queen.valid_move?(4, 4)).to eq false     # destination same as current position
      expect(queen.valid_move?(8, 4)).to eq false     # off board
      expect(queen.valid_move?(5, 2)).to eq false     # not hvd
      expect(queen.valid_move?(0, 4)).to eq false     # obstructed (horizontal)
      expect(queen.valid_move?(4, 7)).to eq false     # obstructed (vertical)
      expect(queen.valid_move?(0, 1)).to eq false     # obstructed (diagonal)
      expect(queen.valid_move?(6, 2)).to eq true      # valid
    end
  end
end
