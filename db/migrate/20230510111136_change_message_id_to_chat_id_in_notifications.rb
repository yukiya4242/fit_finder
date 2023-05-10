class ChangeMessageIdToChatIdInNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_index :notifications, :message_id
    rename_column :notifications, :message_id, :chat_id
    add_index :notifications, :chat_id
  end
end
