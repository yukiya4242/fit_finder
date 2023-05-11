class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:edit, :update]
  before_action :set_user,           only:[:edit, :update]
  before_action :check_user_status,  only:[:show]


  def set_user
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @posts = Post.all
    @users = User.where(is_deleted: false)
  end

  def show
    # binding.pry
    @user = User.find(params[:id])
    @posts = @user.posts

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user = User.update(user_params)
    redirect_to user_path, notice: "ユーザーの情報が更新されました。"
    else
    render :edit
    end
  end

  def liked_posts
    @user = User.find(params[:id])
    @liked_posts = @user.liked_posts
  end


  def hide
    @user = User.find(params[:id])
    @user.update(is_deleted: true) #is_deletedカラムにフラグを立てる(defaultはfalse)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end


  def chat_history
    rooms = current_user.user_rooms.pluck(:room_id) # ログイン中のユーザーの部屋情報を全て取得
    @chat_users = User.joins(:user_rooms).where(user_rooms: { room_id: rooms }).where.not(id: current_user)
  end



  def follow
  @user = User.find(params[:id])
  current_user.following << @user #current_userが対象のユーザー(@user)をfollowing
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
    @keyword = params[:keyword] #検索キーワドを取得
    if @keyword.present? #もしキーワードが入力されていたら
      @users = User.where("username LIKE ?", "%#{@keyword}%" ) #そのキーワードを持つユーザーを取得し@usersに格納
    else
      @users = User.all #キーワードが入力されていない場合はすべてのユーザーを取得
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :profile_picture, :introduction, :location, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:email, :username, :profile_picture, :introduction, :location, :password, :password_confirmation)
  end

  def check_user_status
    user = User.find(params[:id])
    if user.is_deleted
      redirect_to root_path
  end
end
end
