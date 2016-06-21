require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe 'valid_move?' do
    it 'should return true if valid, false if invalid' do
      game = FactoryGirl.create(:game)
      knight = FactoryGirl.create(:knight, game_id: game.id)
      knight2 = FactoryGirl.create(:knight, x_coordinate: 7, y_coordinate: 0, game_id: game.id)
      test = 0
      (-1..8).each do |y|
        (-1..8).each do |x|
          test += 1 if knight.valid_move?(x, y) == true  # => 8
          test += 1 if knight2.valid_move?(x, y) == true # => 2
        end
      end
      expect(test).to eq(10)
      expect(knight.valid_move?(3, 5)).to eq true
      expect(knight.valid_move?(2, 4)).to eq true
      expect(knight.valid_move?(2, 2)).to eq true
      expect(knight.valid_move?(3, 1)).to eq true
      expect(knight.valid_move?(5, 5)).to eq true
      expect(knight.valid_move?(6, 4)).to eq true
      expect(knight.valid_move?(6, 2)).to eq true
      expect(knight.valid_move?(5, 1)).to eq true
      expect(knight.valid_move?(2, 5)).to eq false
    end
  end
end
