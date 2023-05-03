class ConversationsController < ApplicationController

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.order(created_at: :asc)
    Rails.logger.debug @messages.inspect
    @message = Message.new
  end

end
