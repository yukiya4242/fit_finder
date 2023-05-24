class RemoveReadFromChats < ActiveRecord::Migration[6.0]
  def change
    remove_column :chats, :read, :boolean
  end
end
