require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user3) { FactoryGirl.create(:user) }
  let(:test_game) { FactoryGirl.create(:game, name: 'hello', player_white_id: user.id, player_black_id: user2.id, user_id: user.id) }
  let(:white_pawn) { test_game.pieces.find_by(x_coordinate: 4, y_coordinate: 1) }
  let(:black_knight) { test_game.pieces.find_by(x_coordinate: 6, y_coordinate: 7) }

  describe 'pieces#update action' do
    it 'should have http 404 error if game or piece cannot be found' do
      sign_in user2
      put :update, game_id: 'DNE', id: 'DNE', x_pos: 4, y_pos: 3
      expect(response).to have_http_status(:not_found)
    end

    it 'should not allow unauthenticated users to move pieces' do
      white_pawn = test_game.pieces.find_by(x_coordinate: 4, y_coordinate: 1)
      put :update, game_id: test_game.id, id: white_pawn.id, x_pos: 4, y_pos: 3
      test_game.reload
      expect(response).to redirect_to new_user_session_path
    end

    it 'should not allow users who are not either the white or black player to move pieces' do
      sign_in user3
      put :update, game_id: test_game.id, id: white_pawn.id, x_pos: 4, y_pos: 3
      test_game.reload
      expect(response).to have_http_status(:forbidden)
      expect(test_game.pieces.find_by(x_coordinate: 4, y_coordinate: 3)).to eq nil
    end

    it 'should only allow users to move pieces that match their color' do
      sign_in user
      put :update, game_id: test_game.id, id: white_pawn.id, x_pos: 4, y_pos: 3
      test_game.reload
      expect(response).to redirect_to game_path(test_game)
      expect(test_game.pieces.find_by(x_coordinate: 4, y_coordinate: 3)).to be_present
      put :update, game_id: test_game.id, id: black_knight.id, x_pos: 5, y_pos: 5
      expect(response).to have_http_status(:forbidden)
      expect(test_game.pieces.find_by(x_coordinate: 5, y_coordinate: 5)).to eq nil
    end
  end
end
