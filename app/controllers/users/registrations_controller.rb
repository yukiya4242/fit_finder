class Users::RegistrationsController < Devise::RegistrationsController
private

  def sign_up_params
    params.require(:user).permit(:email, :username, :profile_picture, :introduction, :location, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :username, :profile_picture, :introduction, :location, :password, :password_confirmation, :current_password)
  end
end
