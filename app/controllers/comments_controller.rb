class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comments_params)
    comment.post_id = post.id
    comment.save
    redirect_to posts_path(post)

    #通知
    @comment = Comment.new(comment_params)
    @post = @comment.post
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      respond_to :js
    else
      render 'posts/show'
    end
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
