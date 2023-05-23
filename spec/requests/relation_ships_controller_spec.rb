require 'rails_helper'

RSpec.describe RelationshipsController, type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      it 'follows the other user and creates a notification' do
        expect {
          post '/relationships', params: { relationship: { following_id: other_user.id } }, xhr: true
        }.to change(user.followings, :count).by(1)
        .and change(other_user.followers, :count).by(1)
        .and change(other_user.notifications, :count).by(1)

        expect(response).to be_successful  # response should be successful because we're using Ajax
      end
    end

    context 'when user is not authenticated' do
      before do
        sign_out user
      end

      it 'does not allow the user to follow other users' do
        expect {
          post '/relationships', params: { relationship: { following_id: other_user.id } }, xhr: true
        }.not_to change(user.followings, :count)

        expect(response).to have_http_status(:unauthorized)  # response should be 'unauthorized' because user is not signed in
      end
    end
  end
end
