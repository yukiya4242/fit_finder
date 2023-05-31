class Users::SessionsController < Devise::SessionsController
  before_action :reject_user, only: [:create]

  def new_guest
    user = User.guest
    sign_in user
    redirect_to users_path, notice: 'ゲストユーザーとしてログインしました'
  end

  protected

  def reject_user #特定のユーザーをログインできなくする
    @user = User.find_by(email: params[:user][:email].downcase) #入力されたメールアドレスに対応するユーザーをDBから探す
    #もしユーザーが見つかり入力されたパスワードが正しいかつ、ユーザーが認証状態ではない場合、つまり退会済みの場合
    if @user && @user.valid_password?(params[:user][:password]) && !@user.active_for_authentication? == false
      flash[:error] = "退会済みです"
    else
      flash[:error] = "必須項目を入力してください" #ユーザーは認証できるがパスワードかメールアドレスが間違ってる場合
    end
    redirect_to new_user_session_path 
  end
end
