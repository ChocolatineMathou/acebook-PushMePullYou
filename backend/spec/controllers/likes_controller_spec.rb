# frozen_string_literal: true

require "rails_helper"

RSpec.describe LikesController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:customer]
    @customer = Customer.create(first_name: "test", last_name: "rspec", email: "testing@rspec.com", password: "123456", password_confirmation: "123456")
    @post = Post.create(message: "this is a like", customer_id: @customer.id)
    sign_in @customer
  end

  describe "POST /" do
    it "given a post is not already liked it adds a like to the table" do
      expect { post :create, params: { post_id: @post.id } }.to change { Like.all.length }.by(1)
    end

    it "given a post is already liked it removes a like to the table" do
      post :create, params: { post_id: @post.id }
      expect { post :create, params: { post_id: @post.id } }.to change { Like.all.length }.by(-1)
    end
  end
end
