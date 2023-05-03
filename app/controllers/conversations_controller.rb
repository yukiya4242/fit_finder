class ConversationsController < ApplicationController

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
    @message = Message.new
  end

end
