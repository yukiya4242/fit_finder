class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comments_params)
    comment.post_id = post.id
    comment.save
    redirect_to posts_path(post)
  end


  def destroy
    Comment.find(params[:id]).destroy
    redirect_to posts_path(params[:post_id])
  end


  private

  def comments_params
    params.require(:comment).permit(:content)
  end

end
