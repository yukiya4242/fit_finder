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
        invalid_params = { post: { content: "" } }
        expect {
          post '/posts', params: invalid_params
        }.not_to change(Post, :count)

        expect(flash[:danger]).to eq '投稿に失敗しました。もう一度お試しください'
        expect(response).to redirect_to(posts_path)
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
    let(:user) { create(:user) }
    it 'returns a successful response' do
      sign_in user
      get '/posts'
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }

    it 'returns a successful response' do
      sign_in user
      get "/posts/#{post.id}/edit"
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    let(:valid_params) { { post: { content: 'New Content' } } }
    let(:invalid_params) { { post: { content: "" } } }

    it 'updates the post with valid parameters' do
      sign_in user
      patch "/posts/#{post.id}", params: valid_params
      expect(response).to redirect_to(post_path(post))
      expect(post.reload.content).to eq 'New Content'
    end

    it 'does not update the post with invalid parameters' do
      sign_in user
      patch "/posts/#{post.id}", params: invalid_params
      expect(response).to render_template(:edit)
      expect(post.reload.content).not_to eq ''
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }  # Create a test user
    let(:post) { create(:post, user: user) }  # Add post

    it 'returns a successful response' do
      sign_in user
      get "/posts/#{post.id}"
      expect(response).to be_successful
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }  # Create a test user
    let(:post) { create(:post, user: user) }  # Add post

    it 'deletes the post' do
      sign_in user
      delete "/posts/#{post.id}"
      expect(response).to redirect_to(posts_path)
      expect(Post.exists?(post.id)).to be_falsey  # Check post does not exist
    end
  end
end

