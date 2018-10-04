require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

  let(:valid_params) { { first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456"} }
  let(:invalid_params) {{ first_name: "test", last_name: "rspec", password: "123456", password_confirmation: "123456"}}

  describe "POST /" do

    before do
      @request.env["devise.mapping"] = Devise.mappings[:customer]
    end

    context "with valid params" do
      it "returns json data" do
        post :create, params: valid_params
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json')
      end

      it "adds a customer to the table" do
        expect { post :create, params: valid_params }.to change { Customer.all.length }.by(1)
      end

      it "provides a success indication" do
        post :create, params: valid_params
        expect(JSON.parse(response.body)["success"]).to eq true
        expect(JSON.parse(response.body)["current_customer"]["email"]).to eq "testing@rspec.com"
      end

      it "assigns customer to current_customer" do
        post :create, params: valid_params
        expect(subject.current_customer.email). to eq "testing@rspec.com"
      end

      it "sends session data" do
        post :create, params: valid_params
        expect(JSON.parse(response.body)["session"]).to eq session["warden.user.customer.key"]
      end
    end

    context "with invalid params" do
      it "does not create a new customer" do
        post :create, params: invalid_params
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json')
      end

      it "doesn't add customer to the table" do
        expect { post :create, params: invalid_params }.to change { Customer.all.length }.by(0)
      end

      it "provides unsuccessful indication" do
        post :create, params: invalid_params
        expect(JSON.parse(response.body)["success"]).to eq false
        expect(JSON.parse(response.body)["message"]).to eq "Oooops"
      end

      it "doesn't assign customer to current_customer" do
        post :create, params: invalid_params
        expect(subject.current_customer).to eq nil
      end
    end

    # context "email uniqueness" do
    #   it "does not create a new customer" do
    #     post :create, params: { first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456"}
    #     post :create, params: { first_name: "testing", last_name: "iloverspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456"}
    #     expect(response).to be_successful
    #     expect(response.content_type).to eq('application/json')
    #   end
    #
    #   it "does not add customer to the table" do
    #     post :create, params: { first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456"}
    #     expect { post :create, params: { first_name: "testing", last_name: "iloverspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456"} }.to change { Customer.all.length }.by(0)
    #   end
    #
    #   it "provides unsuccessful indication" do
    #     post :create, params: { first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456"}
    #     post :create, params: { first_name: "testing", last_name: "iloverspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456"}
    #     expect(JSON.parse(response.body)["success"]).to eq false
    #     expect(JSON.parse(response.body)["message"]).to eq "Email address already used."
    #   end
    # end
  end
end
