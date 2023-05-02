class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update
    redirect_to user_path
  end

  def following
  end

  def followers
  end

  def search
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :profile_picture, :introduction, :location, :password, :password_confirmation)
  end
end
