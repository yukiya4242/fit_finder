ActiveAdmin.register Like do

  index do
    selectable_column
    id_column
    column :user
    column :post
    column :created_at
    actions
  end
  
      
   actions :all
end
