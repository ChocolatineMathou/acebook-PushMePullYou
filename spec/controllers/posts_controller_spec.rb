require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  before do
    # @request.env["devise.mapping"] = Devise.mappings[:posts]
    @customer = Customer.create({ first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456" })
    @customer_id = Customer.find_by(email: "testing@rspec.com").id
  end

  # posts POST request
  # URI pattern /posts/
  # posts#create

  describe "POST /" do
    it "returns json data" do
      post :create, params: { post: { message: "this is a test", customer_id: @customer_id } }
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json')
    end

    it "adds a post to the table" do
      expect { post :create, params: { post: { message: "this is a test", customer_id: @customer_id } } }.to change { Post.all.length }.by(1)
    end

    it "provides a success indication" do
      post :create, params: { post: { message: "this is a test", customer_id: @customer_id } }
      expect(JSON.parse(response.body)["success"]).to eq true
      expect(JSON.parse(response.body)["post"]["message"]).to eq "this is a test"
    end

  end

  # posts GET request
  # URI pattern /posts/
  # posts#index

  describe "GET /" do

    before do
      post :create, params: { post: { message: "this is a test", customer_id: @customer_id } }
      post :create, params: { post: { message: "this is a second test", customer_id: @customer_id } }
      @post_1 = Post.find_by(message: "this is a test")
      @post_2 = Post.find_by(message: "this is a second test")
    end

    it "returns json data" do
      get :index
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json')
    end

    it "posts in chronological order" do
      get :index
      expect(JSON.parse(response.body)).to eq ({
      "posts" => [
        { "id" => @post_2.id,
        "message" => @post_2.message,
        "created_at" => @post_2.created_at.as_json,
        "updated_at" => @post_2.updated_at.as_json,
        "customer_id" => @post_2.customer_id,
        "first_name" => @customer.first_name,
        "last_name" => @customer.last_name },
        { "id" => @post_1.id,
        "message" => @post_1.message,
        "created_at" => @post_1.created_at.as_json,
        "updated_at" => @post_1.updated_at.as_json,
        "customer_id" => @post_1.customer_id,
        "first_name" => @customer.first_name,
        "last_name" => @customer.last_name }
        ]})
    end

  end

  # post DELETE request
  # URI pattern /posts/:id
  # posts#destroy

  describe "DELETE /" do

    it "passes destroy method to Post" do
      expect(Post).to receive(:destroy).with("1")
      delete :destroy, params: { id: 1 }
    end

    it "responds with 302" do
      allow(Post).to receive(:destroy)
      delete :destroy, params: { id: 1 }
      expect(response).to have_http_status(302)
    end

    it "redirects to posts_url" do
      allow(Post).to receive(:destroy)
      delete :destroy, params: { id: 1}
      expect(response).to redirect_to(posts_url)
    end
  end

end
