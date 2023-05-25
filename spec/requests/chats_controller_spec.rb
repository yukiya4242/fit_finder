# require 'rails_helper'


# RSpec.describe ChatsController, type: :request do
#   describe 'GET #show' do
#     let(:user) { create(:user) }
#     let(:other_user) { create(:user) }
#     let(:room) { create(:room, :with_notifications) }


#     context 'when user has related user room' do
#       before do
#         #ログイン中のユーザーを作成、user_roomも作成
#         sign_in(user)
#         create(:user_room, user: user, room: room)
#         get chat_path(user)
#       end

#       it 'returns a successful response' do
#         expect(response).to have_http_status(:success)
#       end

#       it "assings the correct instance valiable" do #インスタンスを割り当てる
#         expect(assigns(:user)).to eq(user)
#         expect(assings(:room)).to eq(room)
#         expect(assings(:chats)).to eq(room.chats)
#         expect(assings(:chat)).to be_a_new(chat)
#       end
#     end


#     context 'when user does not have related user room' do #ユーザーがルームを持っていない場合
#       before do
#         sign_in(user) #ログインさせる
#         get chat_path(user) #GETリクエスト送信
#       end

#       it 'returns a successful response' do
#         expect(response).to have_http_status(:success)
#       end

#       it 'assings the correct instans variables' do
#         expect(assigns(:user)).to eq(user)
#         expect(assigns(:room)).to be_a_new(Room)
#         expect(assigns(:chats)).to eq([])
#         expect(assigns(:chat)).to be_a_new(Chat)
#       end

#       it 'creates a new user room and room' do
#         expect(UserRoom.count).to eq(2) #中間テーブルレコードが2つ作成されているか確認
#         expect(Room.count).to eq(1) #1つのルームが作成されているか確認
#       end
#     end
#   end
# end

