require 'rails_helper'

RSpec.describe LikesController, type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    it 'creates a new like' do
      expect {
        post post_likes_path(post)
      }.to change(Like, :count).by(1)
    end
  end

  describe 'DELETE #destroy' do
    let!(:like) { create(:like, user: user, post: post) }

    it 'deletes the like' do
      expect {
        delete post_like_path(post, like)
      }.to change(Like, :count).by(-1)
    end
  end
end
