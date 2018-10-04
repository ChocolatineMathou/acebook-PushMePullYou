class PostsController < ApplicationController

  def create
    post = Post.create(post_params)
    render :json => { :success=> true, current_customer: current_customer, session: session["warden.user.customer.key"], post: { message: post.message } }
  end

  def index
    posts = Post.all.reverse
    posts.map! { |post| post = post.json_format }
    render :json => { success: true, current_customer: current_customer, session: session["warden.user.customer.key"], posts: posts }
  end

  def destroy
    Post.destroy(params[:id])
    render :json => { success: true, current_customer: current_customer, session: session["warden.user.customer.key"] }
  end

  private

  def post_params
    params[:post][:customer_id] = current_customer.id unless current_customer == nil
    params.require(:post).permit(:message, :customer_id)
  end
end
