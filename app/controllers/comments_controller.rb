class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comments_params)
    @comment.post_id = post.id

    if @comment.save
      post.create_notification_comment!(current_user, @comment.id)
      flash[:notice] = "コメントを投稿しました"
      redirect_to post_path(@user)
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
