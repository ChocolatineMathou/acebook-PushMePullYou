# frozen_string_literal: true

module SignUpHelper
  def sign_up(first_name, last_name, email, password)
    visit "/customers/sign_up"
    fill_in "customer_first_name", with: first_name
    fill_in "customer_last_name", with: last_name
    fill_in "customer_email", with: email
    fill_in "customer_password", with: password
    fill_in "customer_password_confirmation", with: password
    click_button "Sign up"
  end
end
