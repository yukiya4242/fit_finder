ActiveAdmin.register User do

  permit_params(:username, :email, :profile_picture, :introduction, :experience, :certification, :education, :location, :is_deleted)
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :profile_picture, :introduction, :experience, :certification, :education, :location
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :profile_picture, :introduction, :experience, :certification, :education, :location]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
