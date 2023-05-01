ActiveAdmin.register Message do
  
  index do
    selectable_column
    id_column
    column :sender
    column :receiver
    column :content
    column :created_at
    actions
  end
  
  
  show do
    attributes_table do
      row :id
      row :sender
      row :receiver
      row :content
      row :created_at
      row :updated_at
    end
  end  
  
  
   actions :all
end
