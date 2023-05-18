ActiveAdmin.register Post, as: "Post" do
 menu label: '投稿'

 permit_params :content, :image, :user_id

 index do
   selectable_column
   id_column
   column :user
   column :created_at
   column :updated_at
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
     row :image do |post|
      if post.image.attached?
       image_tag url_for(post.image), width: '40%', height: '40%'
      end
     end
     row :video do |post|
      if post.video.attached?
       video_tag url_for(post.video), controls: true, width: '40%', height: '40%'
      end
    end
 end
end


  actions :all
end

