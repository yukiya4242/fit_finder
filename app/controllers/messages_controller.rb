class MessagesController < ApplicationController

  def create
    Rails.logger.debug params.inspect
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    @message.sender = current_user

    if @message.save
      redirect_to conversation_path(@conversation)
    else
      render 'conversations/show'
    end
  end


  def index
  end

  def show
  end

  private

  def message_params
    params.require(:message).permit(:content, :conversation_id, :image)
  end
end
