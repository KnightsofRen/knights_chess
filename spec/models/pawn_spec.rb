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

    it 'should return true if allowed 1 space' do
      current_pawn = FactoryGirl.create(:pawn)
      expect(current_pawn.valid_move?(0, 7)).to eq(true)
    end

    it 'should return false if move out of bounds' do
      current_pawn = FactoryGirl.create(:pawn)
      expect(current_pawn.valid_move?(0, 8)).to eq(false)
    end
  end
end
