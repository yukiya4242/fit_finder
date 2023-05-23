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
  
  describe 'GET #index' do
    it 'returns a successful response' do
      get '/posts'
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get "/posts/#{post.id}/edit"
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:valid_params) { { post: attributes_for(:post) } }
    let(:invalid_params) { { post: attributes_for(:post, title: '') } }

    it 'updates the post with valid parameters' do
      patch "/posts/#{post.id}", params: valid_params
      expect(response).to redirect_to(post_path(post))
    end

    it 'does not update the post with invalid parameters' do
      patch "/posts/#{post.id}", params: invalid_params
      expect(response).to render_template(:edit)
    end
  end

    describe 'GET #show' do
      it 'returns a successful response' do
        get "/posts/#{post.id}"
        expect(response).to be_successful
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes the post' do
        delete "/posts/#{post.id}"
        expect(response).to redirect_to(posts_path)
        expect(flash[:notice]).to eq '投稿を削除しました'
      end
    end
  end
end
