class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:edit, :update, :index, :liked_posts, :chat_history, :follow, :unfollow, :following, :followers, :showq]
  # before_action :set_user,           only:[:edit, :update]
  before_action :check_user_status,  only:[:show]
  before_action :logged_in_user,     only:[:edit, :chat_history]



  def index
    @user = current_user
    @all_users = User.all
    @posts = Post.all
    @users = User.where(is_deleted: false).where.not(email: 'guest@example.com')
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
  if @user.update(update_params)
    redirect_to @user
  else
    p @user.errors
    render 'edit'
  end
  end


  def liked_posts
    @user = current_user
    @liked_posts = @user&.liked_posts.page(params[:page]).per(20)
  end


  def hide
    @user = User.find(params[:id])
    @user.update(is_deleted: true) #is_deletedカラムにフラグを立てる(defaultはfalse)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end


  def chat_history
    @user = current_user
    rooms = current_user.user_rooms.pluck(:room_id) # ログイン中のユーザーの部屋情報を全て取得
    @chat_users = User.joins(:user_rooms).where(user_rooms: { room_id: rooms }).where.not(id: current_user)
  end



  def follow
  @user = User.find(params[:id])
  current_user.following << @user #current_userが対象のユーザー(@user)をfollowing

  notification = current_user.active_notifications.new(
    visited_id: @user.id,
    action: 'follow'
    )

  notification.save if notification.valid?
  respond_to do |format|
    format.html { redirect_to @user}
    format.js
  end
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.active_relationships.find_by(followed_id: @user.id).destroy #current_userと解除対象ユーザー（@user.id）を.destroy
    respond_to do |format|
      format.html { redirect_to @user}
      format.js
      end
  end



  def following
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end



  def search
    @user = current_user
    @keyword = params[:keyword] #検索キーワドを取得
    @type    = params[:type]
    if @keyword.present? #もしキーワードが入力されていたら
     case @type
     when 'user'
       @users = User.where("username LIKE ?", "%#{@keyword}%" )
       @posts = nil
      when 'post'
        @users = nil
        @posts = Post.where("content LIKE ?", "%#{@keyword}%" )
      else
        @users = User.all
        @posts = Post.all
     end
    else
      @users = User.all
      @posts = Post.all
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :username, :profile_picture, :introduction, :location, :password, :password_confirmation, :current_password)
  end

  def update_params
    params.require(:user).permit(:email, :username, :profile_picture, :introduction, :location, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in_user
      flash[:danger] = "ログインしてください"
      redirect_to new_user_session_path, status: :see_other
    end
  end

  def check_user_status
    user = User.find(params[:id])
    if user.is_deleted
      redirect_to root_path
    end
  end
end
