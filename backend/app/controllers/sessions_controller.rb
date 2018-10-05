# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  # overrides devises methods for checking if user is already signed out (prevents flash messages)
  skip_before_action :verify_signed_out_user

  def create
    customer = Customer.find_by(email: params[:email])

    if !!customer
      if customer.valid_password?(params[:password])
        sign_in customer
        render json: { success: true,
                       current_customer: current_customer,
                       session: session["warden.user.customer.key"] }
      else
        render json: { success: false,
                       current_customer: nil,
                       session: nil,
                       message: "Invalid email or password" }
      end
    else
      render json: { success: false,
                     current_customer: nil,
                     session: nil,
                     message: "Account doesn't exist" }
    end
  end

  def destroy
    sign_out current_customer
    render json: { success: true, current_customer: nil, session: nil }
  end
end