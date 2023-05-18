ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do |admin_user|
    # ここにshowページの内容を記述
    # filterはここには不要
  end
end
