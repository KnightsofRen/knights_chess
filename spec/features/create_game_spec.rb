require 'rails_helper'

RSpec.feature 'create a new game' do
  background do
    User.create(email: 'user@example.com', username: 'user', password: 'password')
  end

  scenario 'user will be redirected to sign in page if not signed in' do
    visit '/games/new'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
    expect(page).to have_button('Log in')
  end

  scenario 'signed in user can create a new game, specifying name and what color to play as' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content('user')

    click_link 'Create New Chess Game' # visit '/games/new'
    fill_in 'Name', with: 'Test-Game'
    select('black', from: 'color')
    click_button 'Create Game'

    expect(page).to have_content('Test-Game')
    expect(page).to have_content('vs.')
    expect(page).to have_css('div.gravatar-box')

    expect(Game.last.player_white_id).to eq nil
    expect(Game.last.player_black_id).to eq User.last.id
    expect(Game.last.user_id).to eq User.last.id
  end
end
