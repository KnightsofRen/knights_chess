require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move' do
    it 'should return false if move backwards' do
      current_pawn = FactoryGirl.create(:pawn)
      expect(current_pawn.valid_move?(0, 0)).to eq(false)
    end

    it 'should return true if first move' do
      current_pawn = FactoryGirl.create(:pawn)
      expect(current_pawn.valid_move?(0, 2)).to eq(true)
      expect(current_pawn.valid_move?(0, 3)).to eq(true)
    end

    it 'should return false if first move horizontal' do
      current_pawn = FactoryGirl.create(:pawn)
      expect(current_pawn.valid_move?(1, 1)).to eq(false)
    end

    it 'should return true if moving forward 1 space' do
      current_pawn = FactoryGirl.create(:pawn)
      expect(current_pawn.valid_move?(0, 2)).to eq(true)
    end

    it 'should return false if move out of bounds' do
      current_pawn = FactoryGirl.create(:pawn)
      expect(current_pawn.valid_move?(0, 8)).to eq(false)
    end

    it 'should return false' do
      current_pawn = FactoryGirl.create(:pawn)
      expect(current_pawn.valid_move?(5, 7)).to eq(false)
    end

    it 'should return false if path obstructed' do
      game = FactoryGirl.create(:game)
      current_pawn = FactoryGirl.create(:pawn, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 3, y_coordinate: 2, game_id: game.id)
      expect(current_pawn.valid_move?(3, 3)).to eq(false)
    end

    it 'should return true if path NOT obstructed' do
      game = FactoryGirl.create(:game)
      current_pawn = FactoryGirl.create(:pawn, game_id: game.id)
      FactoryGirl.create(:piece, x_coordinate: 0, y_coordinate: 7, game_id: game.id)
      expect(current_pawn.valid_move?(0, 5)).to eq(true)
    end
  end
end
