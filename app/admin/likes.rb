ActiveAdmin.register Like do
  permit_params :post_id, :user_id

  index do
    selectable_column
    id_column
    column :user
    column :post
    column :created_at
    column :updated_at
    actions
  end


   actions :all
end
