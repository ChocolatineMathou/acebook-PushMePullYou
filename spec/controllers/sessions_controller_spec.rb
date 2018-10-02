require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  # devise/sessions#create
  describe "POST /" do

    before do
      @request.env["devise.mapping"] = Devise.mappings[:customer]
      @customer = Customer.create({ first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456" })
      @customer_id = Customer.find_by(email: "testing@rspec.com").id
            # post :create, params: {email: "testing@rspec.com", password: "123456"}
    end
    
    context "given valid sign up details" do
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

    context "given invaid sign up details" do

      it "responds in json format" do

      end

      it "provides an unsuccessfull indication" do

      end

      it "does not assign customer to current_customer" do

      end

    end

  end

end
