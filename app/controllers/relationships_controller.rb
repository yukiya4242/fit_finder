class RelationshipsController < ApplicationController

    def create
    @user = User.find(params[:relationship][:following_id])
    current_user.follow!(@user)
    # ここから
    @user.create_notification_follow!(current_user)
    puts "create_notification_follow! has been called." # ログ出力
    # ここまで
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end