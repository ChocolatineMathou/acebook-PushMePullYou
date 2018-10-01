require 'rails_helper'

RSpec.feature "Delete Posts", type: :feature do

  before do
    visit '/customers/sign_up'
    fill_in 'customer_email', with: 'test@test.com'
    fill_in 'customer_password', with: 'test123'
    fill_in 'customer_password_confirmation', with: 'test123'
    click_button 'Sign up'
    click_link 'get :posts'
    fill_in 'post_message', with: 'test'
    click_button 'Submit'
  end

  scenario 'A signed in user can delete their post' do
    expect(page).to have_content 'test'
    expect(page).to have_button 'post.delete?'
    click_button 'post.delete?'
    expect(page).not_to have_content 'test'
    expect(URI.parse(current_url).path).to eq '/posts'
  end

end