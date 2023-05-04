class ConversationsController < ApplicationController

  def show
    @conversation = Conversation.find(params[:id])
    if @conversation.sender_id == current_user.id || @conversation.receiver_id == current_user.id
    @messages = @conversation.messages.order(created_at: :asc)
    @message = Message.new
    end
  end
end
