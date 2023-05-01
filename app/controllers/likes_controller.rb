class LikesController < ApplicationController


  def create
    post = Post.find(params[:post_id])
    likes = current_user.likes.new(post_id: post.id)
    likes.save
    redirect_to post_path(post)
  end


  def destroy
    post = Post.find(params[:post_id])
    likes = current_user.likes.find_by(post_id: post.id)
    likes.destroy
    redirect_to post_path(post)
  end

end
