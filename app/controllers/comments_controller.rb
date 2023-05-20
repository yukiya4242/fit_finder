class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comments_params)
    @comment.post_id = @post.id

    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
    else
     @error_message = "コメントの投稿に失敗しました"
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end


  private

  def comments_params
    params.require(:comment).permit(:content, :post_id)
  end

end