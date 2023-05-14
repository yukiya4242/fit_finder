class SavedFilesController < ApplicationController
  def create
    chat = Chat.find(params[:chat_id])
    current_user.saved_files.create(chat: chat)
    head :ok
  end
end
