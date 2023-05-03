class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:edit, :update]
  before_action :set_user,           only:[:edit, :update]


  def set_user
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @posts = Post.all
  end

  def show
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


  def follow
    @user = User.find(params[:id])
    current_user.following << @user #current_userが対象のユーザー(@user)をfollowing
    redirect_to @user
  end


  def unfollow
    @user = User.find(params[:id])
    current_user.active_relationships.find_by(followed_id: @user.id).destroy #current_userと解除対象ユーザー（@user.id）を.destroy
    redirect_to @user
  end


  def following
  end

  def followers
  end

  def search
    @keyword = params[:keyword] #検索キーワドを取得
    if @keyword.present? #もしキーワードが入力されていたら
      @users = User.where("username LIKE ?", "%#{@keyword}" ) #そのキーワードを持つユーザーを取得し@usersに格納
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
end
