module SignUpHelper
  def sign_up
    visit '/customers/sign_up'
    fill_in 'customer_first_name', with: 'PushMe'
    fill_in 'customer_last_name', with: 'PushYou'
    fill_in 'customer_email', with: 'test@test.com'
    fill_in 'customer_password', with: 'test123'
    fill_in 'customer_password_confirmation', with: 'test123'
    click_button 'Sign up'
  end
end
