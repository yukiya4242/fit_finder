class LikesController < ApplicationController


  def create
    @post = Post.find(params[:post_id]) #パラメーらから投稿を見つける
    likes = current_user.likes.new(post_id: @post.id) #新しいいいねを作成
    if likes.save #DBにいいねを保存
    #通知を作成
    @post.create_notification_like!(current_user)
    else
    end
  end


  def destroy
    @post = Post.find(params[:post_id]) #削除する投稿を見つける
    like = current_user.likes.find_by(post_id: @post.id) #ユーザーが投稿したいいねを見つける
    if like.destroy #いいねを削除
    else #何もしない
    end
  end
end
