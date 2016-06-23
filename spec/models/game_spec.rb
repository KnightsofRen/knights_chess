require 'rails_helper'

RSpec.describe Game, type: :model do

  describe 'forfeit' do
    it 'should declare a winner' do
     game = FactoryGirl.create(:game)
     game.forfeit
     expect(game.winning_player_id).to eq(player_black_id)
      


  describe 'populate_board!' do
    let(:game) { FactoryGirl.create(:game) }
    expected = [
      [0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
      [0, 7], [1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7], [7, 7],
      [0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
      [0, 6], [1, 6], [2, 6], [3, 6], [4, 6], [5, 6], [6, 6], [7, 6]
    ]
    white_expected = expected[0..7] + expected[16..23]
    black_expected = expected[8..15] + expected[24..31]

    it 'should create all 32 pieces with their initial (x, y) coordinates' do
      expect(game.board_state).to eq(expected)
    end

    it 'should create pieces with correct color at correct coordinates' do
      white_pieces = []
      black_pieces = []
      game.pieces.each do |piece|
        if piece.white?
          white_pieces << [piece.x_coordinate, piece.y_coordinate]
        else
          black_pieces << [piece.x_coordinate, piece.y_coordinate]
        end
      end
      expect(white_expected == white_pieces && black_expected == black_pieces).to eq(true)
    end

    it 'should create pieces that are not captured' do
      test = 0
      game.pieces.each do |piece|
        test += 1 if piece.captured? == false
      end
      expect(test).to eq(32)
    end

    


    it 'should create pieces with correct type at correct coordinates' do
      test = 0
      [1, 6].each do |y|
        (0..7).each do |x|
          test += 1 if game.pieces.find_by(x_coordinate: x, y_coordinate: y).type == 'Pawn'
        end
      end
      [0, 7].each do |y|
        test += 1 if game.pieces.find_by(x_coordinate: 0, y_coordinate: y).type == 'Rook'
        test += 1 if game.pieces.find_by(x_coordinate: 7, y_coordinate: y).type == 'Rook'
        test += 1 if game.pieces.find_by(x_coordinate: 1, y_coordinate: y).type == 'Knight'
        test += 1 if game.pieces.find_by(x_coordinate: 6, y_coordinate: y).type == 'Knight'
        test += 1 if game.pieces.find_by(x_coordinate: 2, y_coordinate: y).type == 'Bishop'
        test += 1 if game.pieces.find_by(x_coordinate: 5, y_coordinate: y).type == 'Bishop'
        test += 1 if game.pieces.find_by(x_coordinate: 3, y_coordinate: y).type == 'Queen'
        test += 1 if game.pieces.find_by(x_coordinate: 4, y_coordinate: y).type == 'King'
      end
      expect(test).to eq(32)
    end
  end
end
