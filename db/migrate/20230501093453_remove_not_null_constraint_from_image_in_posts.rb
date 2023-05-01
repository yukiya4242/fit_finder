# db/migrate/YYYYMMDDHHMMSS_remove_not_null_constraint_from_image_in_posts.rb
class RemoveNotNullConstraintFromImageInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :image, true
  end
end