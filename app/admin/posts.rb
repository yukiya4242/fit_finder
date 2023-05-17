ActiveAdmin.register Post do

 permit_params :content, :image, :user_id

 index do
   selectable_column
   id_column
   column :user
   column :created_at
   actions
end


 form do |f|
   f.inputs do
     f.input :user
     f.input :content
   end
   f.actions
 end


 show do
   attributes_table do
     row :id
     row :user
     row :content
     row :created_at
     row :updated_at
 end
end


  actions :all
end

