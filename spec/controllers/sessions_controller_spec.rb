require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  # devise/sessions#create
  describe "POST /" do

    before do
      @request.env["devise.mapping"] = Devise.mappings[:customer]
      @customer = Customer.create({ first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456" })
      @customer_id = Customer.find_by(email: "testing@rspec.com").id
    end

    context "given valid sign in details" do
      it "responds in json format" do
        post :create, params: {email: "testing@rspec.com", password: "123456"}
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json')
      end

      it "provides a success indication" do
        post :create, params: {email: "testing@rspec.com", password: "123456"}
        expect(JSON.parse(response.body)["success"]).to eq true
      end

      it "assigns customer to current_customer" do
        post :create, params: { email: "testing@rspec.com", password: "123456" }
        expect(subject.current_customer.id).to eq @customer_id
      end
    end

    context "given invalid email" do
      it "responds in json format" do
        post :create, params: {email: "test@test.com", password: "123456"}
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json')
      end

      it "provides an unsuccessful indication" do
        post :create, params: {email: "test@test.com", password: "123456"}
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
        post :create, params: {email: "testing@rspec.com", password: "654321"}
        expect(JSON.parse(response.body)["success"]).to eq false
        expect(JSON.parse(response.body)["message"]).to eq "Invalid email or password"
      end
    end

  end

end
