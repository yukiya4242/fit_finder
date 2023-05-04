class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:message][:conversation_id])
    @message = @conversation.messages.new(message_params)
    @message.sender_id = current_user.id

    # 受信者を設定
    if @conversation.sender_id == current_user.id
      @message.receiver_id = @conversation.receiver_id
    else
      @message.receiver_id = @conversation.sender_id
    end

    if @message.save
      Rails.logger.debug "Message saved successfully"
      redirect_to conversation_path(@conversation)
    else
      Rails.logger.debug "Message failed to save"
      Rails.logger.debug @message.errors.full_messages.join(', ')
      # エラーメッセージを表示するなどの処理を追加
    end
  end

  def index
  end

  def show
  end

  private

  def message_params
    params.require(:message).permit(:content, :conversation_id)
  end
end
