require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  # devise/sessions#create
  describe "POST /" do

    let(:sign_up_params) { {email: "testing@rspec.com", password: "123456" } }
    let(:invalid_email_params) { {email: "testing2@rspec.com", password: "123456" } }
    let(:invalid_password_params) { { email: "testing@rspec.com", password: "654321" } }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:customer]
      customer = Customer.create({ first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456" })
      @customer_id = Customer.find_by(email: "testing@rspec.com").id
    end

    context "given valid sign in details" do
      it "returns in json format" do
        post :create, params: sign_up_params
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json')
      end

      it "provides a success indication" do
        post :create, params: sign_up_params
        expect(JSON.parse(response.body)["success"]).to eq true
      end

      it "assigns customer to current_customer" do
        post :create, params: sign_up_params
        expect(subject.current_customer.id).to eq @customer_id
      end

      it "provides the current_customer in the json" do
        post :create, params: sign_up_params
        expect(JSON.parse(response.body)["current_customer"]["first_name"]).to eq "test"
      end

      it "provides a session key in the json" do
        post :create, params: sign_up_params
        expect(JSON.parse(response.body)["session"]).to eq session["warden.user.customer.key"]
      end
    end

    context "given invalid email" do
      it "responds in json format" do
        post :create, params: invalid_email_params
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json')
      end

      it "provides an unsuccessful indication" do
        post :create, params: invalid_email_params
        expect(JSON.parse(response.body)["success"]).to eq false
        expect(JSON.parse(response.body)["message"]).to eq "Account doesn't exist"
      end

      it "does not assign customer to current_customer" do
        post :create, params: {email: "test@test.com", password: "123456"}
        expect(subject.current_customer).to eq nil
      end
    end

    context "given invalid password" do
      it "provides an unsuccessful indication" do
        post :create, params: invalid_password_params
        expect(JSON.parse(response.body)["success"]).to eq false
        expect(JSON.parse(response.body)["message"]).to eq "Invalid email or password"
      end
    end

  end

  # sessions#destroy
  # DELETE
  # customers/sign_out
  describe "DELETE /" do

    context "given a user is already signed in" do

      before do
        @request.env["devise.mapping"] = Devise.mappings[:customer]
        customer = Customer.create({ first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456" })
        sign_in customer
      end

      it "sets the current_user to nil" do
        delete :destroy
        expect(subject.current_customer).to eq nil
        expect(JSON.parse(response.body)["current_customer"]).to eq nil
      end

      it "returns a success message" do
        delete :destroy
        expect(JSON.parse(response.body)["success"]).to eq true
      end

    end
  end
end
