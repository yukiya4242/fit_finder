class LikesController < ApplicationController


  def create
    @post = Post.find(params[:post_id])
    likes = current_user.likes.new(post_id: @post.id)
    if likes.save
    #通知
    @post.create_notification_like!(current_user)
    else
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    if like.destroy
    else
    end
  end
end
