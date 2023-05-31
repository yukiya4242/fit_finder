ActiveAdmin.register Chat do
 permit_params :user_id, :message, :room_id, :image, :vodeo

 show do
   attributes_table do
     row :user_id
     row :message
     row :room_id

     row :image do |chat|
       if chat.image.attached?
         image_tag url_for(chat.image), style: "width: 400x; height: 400px;"
       end
     end
     row :video do |chat|
       if chat.video.attached?
         video_tag url_for(chat.video), controls: true, style: "width: 400px; height: 400px;"
       end
     end
   end
 end

end
