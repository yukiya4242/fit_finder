require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'POST #create' do
    context 'when user is authenticated' do
      let(:user) { create(:user) }
      let(:valid_params) { { post: attributes_for(:post) } }
      let(:invalid_params) { { post: attributes_for(:post, title: '') } }

      before do
        sign_in user
      end

      it 'creates a new post with valid parameters' do
        expect {
          post '/posts', params: valid_params
        }.to change(Post, :count).by(1)

        expect(flash[:success]).to eq '投稿が完了しました'
        expect(response).to redirect_to(posts_path)
      end

      it 'does not create a new post with invalid parameters' do
        expect {
          post '/posts', params: valid_params
        }.not_to change(Post, :count)

        expect(flash[:danger]).to eq '投稿に失敗しました。もう一度お試しください'
        expect(response).to redirect_to(new_post_path)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
       post '/posts', params: { post: attributes_for(:post) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
