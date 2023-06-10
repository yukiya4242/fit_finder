class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id]) #コメントする投稿を見つける
    @comment = current_user.comments.new(comments_params) #新しいコメントを作成
    @comment.post_id = @post.id #コメントに投稿ID設定する

    #コメントの投稿に成功したら
    if @comment.save
       @post.create_notification_comment!(current_user, @comment.id) #通知を作成
       @comments = @post.comments.order(created_at: :desc) #投稿を全て取得し、降順(新しい順)に並び替え
    else
      @error_message = "コメントの投稿に失敗しました"
    end
  end

  def destroy
    @comment = Comment.find(params[:id]) #コメントを見つける
    @comment.destroy #コメントを削除
  end

  private

  def comments_params
    params.require(:comment).permit(:content, :post_id)
  end
end
