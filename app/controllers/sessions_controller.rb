class SessionsController < Devise::SessionsController

  def create
    # validate that email+>password exists in database
    customer = Customer.find_by(email: params[:email])

    # if it does exist:
    if !!customer
      # create a session: sign_in (customer) --> current_customer
      #success: true, current_customer: current_customer
      sign_in customer
      # current_customer
      # if it doesn't exist:
      # raise an error: success: false?
      render :json => { :success=>true, current_customer: current_customer }
    end
  end

  private

  def sign_in_params
    params.require(:customer).permit(:email, :password)
  end

end
