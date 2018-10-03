class PostsController < ApplicationController

  def create
    post = Post.create(post_params)
    render :json => { :success=> true, current_customer: current_customer, post: { message: post.message } }
  end

  def index
    posts = Post.all.reverse
    # p posts
    posts.map do |post|
      # p post
      post.json_format
      # p post
      # customer = Customer.find(post.customer_id)
      # p customer.first_name
      # p customer.last_name
      # post.first_name = customer.first_name
      # post.last_name = customer.last_name
      # post.send :first_name, customer.first_name
      # post.send("first_name=", "hello")
      # p post
    end
    render :json => { posts: posts }
  end

  def destroy
    Post.destroy(params[:id])
    redirect_to posts_url
  end

  private

  def post_params
    params[:post][:customer_id] = current_customer.id unless current_customer == nil
    params.require(:post).permit(:message, :customer_id)
  end
end
