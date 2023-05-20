class ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]


  def show
    @user = User.find(params[:id]) #チャットする相手は誰？
    rooms = current_user.user_rooms.pluck(:room_id) #ログイン中のユーザーの部屋情報を全て取得
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)#その中にチャットする相手とのルームがあるか確認

    unless user_rooms.nil?#ユーザールームがある場合
      @room = user_rooms.room#変数@roomにユーザー（自分と相手）と紐づいているroomを代入
    else#ユーザールームが無かった場合
      @room = Room.new#新しくRoomを作る
      @room.save#そして保存
      UserRoom.create(user_id: current_user.id, room_id: @room.id)#自分の中間テーブルを作成
      UserRoom.create(user_id: @user.id, room_id: @room.id)#相手の中間テーブルを作成
    end

    @chats = @room.chats #チャットの一覧
    @chat = Chat.new(room_id: @room.id)#チャットの投稿
  end

  def create
  room_id = params[:chat][:room_id] #追加
  another_entry = UserRoom.where(room_id: room_id).where.not(user_id: current_user.id).first #追加
  receiver_id = another_entry.user_id #追加
  @chat = current_user.chats.new(chat_params.merge(sender_id: current_user.id, receiver_id: receiver_id)) #追加
  @room = @chat.room
  @chats = @chat.room.chats
  # byebug
  if @chat.save
    another_entry = UserRoom.where(room_id: @room.id).where.not(user_id: current_user.id).first
    visited_id = another_entry.user_id

    notification = current_user.active_notifications.new(
      room_id: @room.id,
      chat_id: @chat.id,
      visited_id: visited_id,
      visitor_id: current_user.id,
      action: 'dm'
    )

    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end

    notification.save if notification.valid?

    respond_to do |format|
      format.html { redirect_to room_path(@chat.room) }
        format.js
        end
  else
     flash[:alert] = "メッセージの送信に失敗しました。"
     Rails.logger.debug @chat.errors.full_messages
    respond_to do |format|
      format.js { render :create_failed }
      end
    # redirect_back(fallback_location: root_path)
  end
  end

  def read
    chat = Chat.find(params[:id])
    chat.read! if chat.receiver == current_user && !chat.read
    head :ok
  end


#   def destroy
#   @chat = Chat.find(params[:id])
#   if @chat.user_id == current_user.id
#     @chat.destroy
#     flash[:success] = "メッセージを削除しました。"
#     redirect_to room_path(@chat.room)
#   else
#     flash[:alert] = "自分のメッセージのみ削除できます。"
#     redirect_to room_path(@chat.room)
#   end
# 　end



  private


    def chat_params
      params.require(:chat).permit(:message, :room_id, :image, :video)
    end



    def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to posts_path
    end
    end
end