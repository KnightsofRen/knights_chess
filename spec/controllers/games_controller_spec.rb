require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#index action' do
    it 'should successfully show the page' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  let(:user) { FactoryGirl.create(:user) }

  describe 'games#new action' do
    it 'should require users to be logged in' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it 'should successfully show the new form' do
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#create action' do
    it 'should require users to be logged in' do
      post :create, game: { name: 'test game' }
      expect(response).to redirect_to new_user_session_path
    end

    it 'should ??' do
      sign_in user
      post :create, game: { name: 'test game' }
      game = Game.last
      # expect(response).to redirect_to game_path(game.id)
      expect(game.name).to eq 'test game'
    end
  end
end
