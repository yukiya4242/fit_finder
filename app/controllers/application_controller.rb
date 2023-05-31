class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  #ユーザーがログイン後にリダイレクトされるパスを設定
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser) #adminならダッシュボード
    admin_dashboard_path
    else #ユーザーならマイページ
    user_path(current_user)
    end
  end

  #ユーザーがログアウト後にリダイレクトされるパスを定義
  def after_sign_out_path_for(resource)
    root_path
  end

  #未確認の通知を取得するヘルパーメソッド
  helper_method :unchecked_notifications
  def unchecked_notifications
    current_user.passive_notifications.where(checked: false)
  end


  helper_method :current_or_guest_user
  def current_or_guest_user
  if current_user
    return current_user
  else
    return User.guest
  end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :profile_picture, :introduction, :location, :password, :password_confirmation])
  end


end
