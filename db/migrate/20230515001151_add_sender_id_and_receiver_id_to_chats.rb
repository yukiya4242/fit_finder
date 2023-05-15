class AddSenderIdAndReceiverIdToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :sender_id, :integer
    add_column :chats, :receiver_id, :integer
  end
end
