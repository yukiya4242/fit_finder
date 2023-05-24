require 'rails_helper'

RSpec.describe SavedFilesController, type: :request do
  let(:user) { create(:user) }
  let(:chat) { create(:chat) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      it 'saves the chat' do
        expect {
          post "/saved_files", params: { chat_id: chat.id }, xhr: true
        }.to change(user.saved_files, :count).by(1)

        expect(response).to have_http_status(:ok)  # response should be 'OK' because we're using Ajax
      end
    end

       context 'when user is not authenticated' do
        it 'does not allow the user to save the chat' do
          sign_out user

          expect {
            post "/saved_files", params: { chat_id: chat.id }, xhr: true
          }.not_to change(SavedFile, :count)  # SavedFileの数を数える

          expect(response).to have_http_status(:unauthorized)
        end
      end
  end
end
