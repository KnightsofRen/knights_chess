require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  let(:user) { FactoryGirl.create(:user, admin: true) }
  let(:user2) { FactoryGirl.create(:user) }

  describe 'players#index action' do
    it 'should only successfully show the page if user is logged in and is an admin' do
      get :index
      expect(response).to have_http_status(:forbidden)

      sign_in user2
      get :index
      expect(response).to have_http_status(:forbidden)
      sign_out user2

      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
