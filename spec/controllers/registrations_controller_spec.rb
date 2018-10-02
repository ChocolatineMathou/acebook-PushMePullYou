require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

  #registrations#create
  # /customers

  describe "POST /" do
    context "with valid params" do

      before do
        @request.env["devise.mapping"] = Devise.mappings[:customer]
      end

      it "creates a new customer" do
        post :create, params: { first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456"}
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json')
      end

      it "provides a success indication" do
        post :create, params: { first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456"}
        expect(JSON.parse(response.body)["success"]).to eq true
        expect(JSON.parse(response.body)["current_customer"]["email"]).to eq "testing@rspec.com"
      end

      it "assigns customer to current_customer" do
        post :create, params: { first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456"}
        expect(subject.current_customer.email). to eq "testing@rspec.com"
      end
    end

    context "with invalid params" do
      it "does not create a new customer" do
        # expect(true).not_to change(Customer, :count)
      end
    end
  end
end
