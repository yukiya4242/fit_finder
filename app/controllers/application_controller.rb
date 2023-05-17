class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user

  def after_sign_in_path_for(resource)
    users_path
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
    admin_dashboard_path
  else
    root_path
  end
end

  def after_sign_out_path_for(resource)
    root_path
  end

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

  def set_current_user #どのページでも@userがcurrent_userとして使える様になる
    @user = current_user
  end


end
