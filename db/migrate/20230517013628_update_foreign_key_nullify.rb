class UpdateForeignKeyNullify < ActiveRecord::Migration[6.1]
  def up
    change_column_null :saved_files, :user_id, true
    change_column_null :chats, :sender_id, true
    change_column_null :chats, :receiver_id, true
  end

  def down
    change_column_null :saved_files, :user_id, false
    change_column_null :chats, :sender_id, false
    change_column_null :chats, :receiver_id, false
  end
end
