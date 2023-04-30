class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.text :content, null: false
      t.string :image, null: false

      t.timestamps
    end
  end
end
