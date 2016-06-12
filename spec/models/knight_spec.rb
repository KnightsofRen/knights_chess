require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe 'valid_move?' do
    it 'should return true if valid, false if invalid' do
      game = FactoryGirl.create(:game)
      knight = FactoryGirl.create(:knight, game_id: game.id)
      knight2 = FactoryGirl.create(:knight, x_coordinate: 6, y_coordinate: 2, game_id: game.id)
      knight3 = FactoryGirl.create(:knight, x_coordinate: 6, y_coordinate: 1, game_id: game.id)
      knight4 = FactoryGirl.create(:knight, x_coordinate: 7, y_coordinate: 0, game_id: game.id)
      test = 0
      (-1..8).each do |y|
        (-1..8).each do |x|
          test += 1 if knight.valid_move?(x, y) == true  # => 8
          test += 1 if knight2.valid_move?(x, y) == true # => 6
          test += 1 if knight3.valid_move?(x, y) == true # => 4
          test += 1 if knight4.valid_move?(x, y) == true # => 2
        end
      end
      test += 1 if knight4.valid_move?(6, 2) == true   # top left move
      test += 1 if knight3.valid_move?(4, 0) == true   # bottom left
      test += 1 if knight2.valid_move?(7, 4) == true   # top right
      test += 1 if knight.valid_move?(5, 1) == true    # bottom right
      test += 1 if knight.valid_move?(4, 7) == false
      expect(test).to eq(25)
    end
  end
end
