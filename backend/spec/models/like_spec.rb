# frozen_string_literal: true

require "rails_helper"

RSpec.describe Like, type: :model do
  before do
    @customer = Customer.create(first_name: "Dave", last_name: "Funny", email: "dave@123.com", password: "123456")
    @post = Post.create(message: "hello world", customer_id: @customer.id)
    @like = Like.create(customer_id: @customer.id, post_id: @post.id)
  end

  it "Create a new Like object" do
    expect(subject).to be_a Like
  end

  it "Is linked to a user id" do
    expect(@like.customer_id).to eq @customer.id
  end

  it "Is linked to a post id" do
    expect(@like.post_id).to eq @post.id
  end
end
