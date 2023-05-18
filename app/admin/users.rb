ActiveAdmin.register User do
  actions :all, except: [:new, :create] #管理者は新規の一般ユーザーを作成できないようにする
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

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

  show do
    attributes_table do
      row :id
      row :email
      row :created_at
      row :updated_at
      row :introduction
      row :location
      row :is_deleted
      row :profile_picture do |user|
        if user.profile_picture.attached?
          image_tag(url_for(user.profile_picture), width: '40%', height: '40%')
        end
      end
    end



end
end