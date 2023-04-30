class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :profile_picture, :string
    add_column :users, :introduction, :text
    add_column :users, :experience, :text
    add_column :users, :certification, :text
    add_column :users, :education, :text
    add_column :users, :location, :string
  end
end
