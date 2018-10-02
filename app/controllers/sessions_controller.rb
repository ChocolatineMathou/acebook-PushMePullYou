class SessionsController < Devise::SessionsController

  def create
    # validate that email+>password exists in database
    customer = Customer.find_by(email: params[:email])

    if !!customer
      sign_in customer
      render :json => { :success=>true, current_customer: current_customer }
    else
      render :json => { :success=>false, message: "Invalid email or password"}
    end
  end

  private

  def sign_in_params
    params.require(:customer).permit(:email, :password)
  end

end
