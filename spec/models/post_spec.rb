require "rails_helper"

RSpec.describe Post, type: :model do

  before do
    @customer = Customer.create(first_name: "Dave", last_name: "Funny", email: "dave@123.com", password: "123456")
    @post = Post.create(message: "hello world", customer_id: @customer.id)
  end

  it "creates a new Post object" do
    expect(subject).to be_a Post
  end

  it "is linked to user_id" do
    expect(@post.customer_id).to eq @customer.id
  end

  context "#json_format" do
    it "converts Post object to a hash" do
      expect(@post.json_format).to eq({
        id: @post.id,
        message: @post.message,
        created_at: @post.created_at,
        updated_at: @post.updated_at,
        customer_id: @post.customer_id,
        first_name: @customer.first_name,
        last_name: @customer.last_name
        })
    end
  end

end
