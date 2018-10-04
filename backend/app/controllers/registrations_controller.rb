# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def create
    customer = Customer.create(sign_up_params)

    if customer.valid?
      sign_in customer
      render json: { success: true, current_customer: current_customer, session: session["warden.user.customer.key"] }
    else
      render json: { success: false, message: "Oooops" }
    end
  end

  private

    def sign_up_params
      params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
