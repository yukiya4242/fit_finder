ActiveAdmin.register Comment, as: 'UserComment' do

  permit_params :content, :user_id, :post_id

end
