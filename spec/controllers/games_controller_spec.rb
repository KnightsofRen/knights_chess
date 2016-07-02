require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user3) { FactoryGirl.create(:user) }
  let(:test_game) { FactoryGirl.create(:game, name: 'hello', player_white_id: user.id, user_id: user.id) }
  let(:params) do
    {
      game: { name: 'game #1', user_id: user.id, status: 'safe', turn: 'white' },
      color: '1'
    }
  end

  describe 'games#index action' do
    it 'should successfully show the page' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#show action' do
    it 'should have http 404 error if game cannot be found' do
      get :show, id: 'DNE'
      expect(response).to have_http_status(:not_found)
    end

    it 'should successfully show the page' do
      get :show, id: test_game.id
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#new action' do
    it 'should require users to be logged in' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it 'should successfully show the new form if user is logged in' do
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#create action' do
    it 'should require users to be logged in' do
      post :create, params
      expect(response).to redirect_to new_user_session_path
    end

    it 'should create a game with correct initial attributes if user is logged in' do
      sign_in user
      post :create, params
      game = Game.last
      expect(game.name).to eq 'game #1'
      expect(game.player_white_id).to eq user.id
      expect(game.user_id).to eq user.id
      expect(game.player_black_id).to eq nil
      expect(game.status).to eq 'safe'
      expect(game.turn).to eq 'white'
      expect(game.winning_player_id).to eq nil
      expect(response).to redirect_to game_path(game)
    end
  end

  describe 'games#edit action' do
    it 'should have http 404 error if game cannot be found' do
      sign_in user
      get :edit, id: 'DNE'
      expect(response).to have_http_status(:not_found)
    end

    it 'should not allow unauthenticated users to edit a game' do
      get :edit, id: test_game.id
      expect(response).to redirect_to new_user_session_path
    end

    it 'should only allow the user who created the game to access the form to edit the game' do
      sign_in user2
      get :edit, id: test_game.id
      expect(response).to have_http_status(:forbidden)
      sign_out user2
      sign_in user
      get :edit, id: test_game.id
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#update action' do
    it 'should have http 404 error if game cannot be found' do
      sign_in user
      put :update, id: 'DNE'
      expect(response).to have_http_status(:not_found)
    end

    it 'should not allow unauthenticated users to join the game' do
      put :update, id: test_game.id, game: { player_black_id: 22 }
      test_game.reload
      expect(response).to redirect_to new_user_session_path
      expect(test_game.player_black_id).to eq nil
    end

    it 'should only allow a user who is not the creator of the game to join the game' do
      sign_in user
      put :update, id: test_game.id, game: { player_black_id: user.id }
      test_game.reload
      expect(response).to redirect_to root_path
      expect(test_game.player_black_id).to eq nil
      sign_out user

      sign_in user2
      put :update, id: test_game.id, game: { player_black_id: user2.id }
      test_game.reload
      expect(response).to redirect_to game_path(test_game)
      expect(test_game.player_black_id).to eq user2.id
      sign_out user2

      sign_in user3
      put :update, id: test_game.id, game: { player_black_id: user3.id }
      test_game.reload
      expect(response).to have_http_status(:forbidden)
    end

    it 'should allow creator of game to update game name' do
      sign_in user
      put :update, id: test_game.id, game: { name: 'woohoo' }, on_edit_page: 'yes'
      test_game.reload
      expect(response).to redirect_to game_path(test_game)
      expect(test_game.name).to eq 'woohoo'
    end
  end

  describe 'games#destroy action' do
    it 'should have http 404 error if game cannot be found' do
      sign_in user
      delete :destroy, id: 'DNE'
      expect(response).to have_http_status(:not_found)
    end

    it 'should not allow unauthenticated users to destroy a game' do
      delete :destroy, id: test_game.id
      expect(response).to redirect_to new_user_session_path
    end

    it 'should only allow the user who created the game to destroy the game' do
      sign_in user2
      delete :destroy, id: test_game.id
      expect(response).to have_http_status(:forbidden)
      sign_out user2
      sign_in user
      delete :destroy, id: test_game.id
      expect(response).to redirect_to root_path
      expect(Game.find_by_id(test_game.id)).to eq nil
    end
  end
end
