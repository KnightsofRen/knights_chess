require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    it 'should return true if valid, false if invalid' do
      game = FactoryGirl.create(:game)
      game.pieces.delete_all

      # white pawn at (0, 1) ==> 2 valid moves
      pawn = FactoryGirl.create(:pawn, game_id: game.id)

      # black pawn2 at (2, 6), piece at (2, 5) ==> 0 valid moves
      pawn2 = FactoryGirl.create(:pawn, color: 'black', x_coordinate: 2, y_coordinate: 6, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 2, y_coordinate: 5, game_id: game.id)

      # black pawn3 at (4, 6), piece at (4, 4) ==> 1 valid move
      pawn3 = FactoryGirl.create(:pawn, color: 'black', x_coordinate: 4, y_coordinate: 6, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 4, y_coordinate: 4, game_id: game.id)

      # white pawn4 at (6, 1), pieces at (5, 2) and (7, 2) ==> 4 valid moves
      pawn4 = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 1, game_id: game.id)
      FactoryGirl.create(:piece, color: 'black', x_coordinate: 5, y_coordinate: 2, game_id: game.id)
      FactoryGirl.create(:piece, color: 'black', x_coordinate: 7, y_coordinate: 2, game_id: game.id)

      # white pawn5 at (6, 4), piece (7, 5) ==> 2 valid moves
      pawn5 = FactoryGirl.create(:pawn, x_coordinate: 6, y_coordinate: 4, game_id: game.id)
      FactoryGirl.create(:piece, color: 'black', x_coordinate: 7, y_coordinate: 5, game_id: game.id)

      test = 0
      (-1..8).each do |y|
        (-1..8).each do |x|
          test += 1 if pawn.valid_move?(x, y) == true # ==> 2
          test += 1 if pawn2.valid_move?(x, y) == true # ==> 0
          test += 1 if pawn3.valid_move?(x, y) == true # ==> 1
          test += 1 if pawn4.valid_move?(x, y) == true # ==> 4
          test += 1 if pawn5.valid_move?(x, y) == true # ==> 2
        end
      end
      expect(test).to eq 9

      expect(pawn.valid_move?(0, 2)).to eq true
      expect(pawn.valid_move?(0, 3)).to eq true
      expect(pawn3.valid_move?(4, 5)).to eq true
      expect(pawn3.valid_move?(4, 4)).to eq false
      expect(pawn4.valid_move?(5, 2)).to eq true
      expect(pawn4.valid_move?(6, 3)).to eq true
      expect(pawn5.valid_move?(5, 5)).to eq false
    end
  end
end
