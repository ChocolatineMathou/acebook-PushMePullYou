require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

  let(:params) {{ first_name: "rspec", last_name: "testing", email: "testing@rspec.com", password: "123456", password_confirmation: "123456" }}

  # registrations#new
  # /customers/sign_up
  describe "GET /" do

    context "with valid params" do
      it "creates a new customer" do


      end
    end

    context "with invalid params" do
      it "does not create a new customer" do
        # expect(true).not_to change(Customer, :count)
      end
    end
  end
end
