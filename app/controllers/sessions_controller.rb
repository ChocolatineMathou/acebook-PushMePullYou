class SessionsController < Devise::SessionsController

  def create
    customer = Customer.find_by(email: params[:email])

    if !!customer
      if customer.valid_password?(params[:password])
        sign_in customer
        render :json => { :success=>true, current_customer: current_customer }
      else
        render :json => { :success=>false, message: "Invalid email or password"}
      end
    else
      render :json => { :success=>false, message: "Account doesn't exist"}
    end
  end

end
