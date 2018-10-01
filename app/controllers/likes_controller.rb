class LikesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    if like = Like.find_by(post: post, customer: current_customer)
      like.destroy
    else
      like = Like.create(post: post, customer: current_customer)
    end

    redirect_to posts_path

  end
end
