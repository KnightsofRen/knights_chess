require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'populate_board!' do
    it 'should create all 32 pieces with their initial X/Y coordinates' do
      game = FactoryGirl.create(:game)
      expected = [
        [0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
        [0, 7], [1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7], [7, 7],
        [0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1],
        [0, 6], [1, 6], [2, 6], [3, 6], [4, 6], [5, 6], [6, 6], [7, 6]
      ]
      expect(game.board_state).to eq(expected)
    end
  end
end
