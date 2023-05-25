class SavedFilesController < ApplicationController
  before_action :authenticate_user!, only:[:create]

  def create
    chat = Chat.find(params[:chat_id])
    current_user.saved_files.create(chat: chat)
    head :ok
  end
end
