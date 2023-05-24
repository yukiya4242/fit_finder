ActiveAdmin.register Chat do
 permit_params :user_id, :post_id, :message, :room_id

end
