require 'rails_helper'

RSpec.describe LikesController, type: :request do
  let(:user) { create(:user) }
  let(:post_item) { create(:post, user: user) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    it 'creates a new like' do
      sign_in user
      expect {
        post post_likes_path(post_item), xhr: true
      }.to change(Like, :count).by(1)
    end
  end

  describe 'DELETE #destroy' do
    let!(:like) { create(:like, user: user, post: post_item) }

    it 'deletes the like' do
      sign_in user
      expect {
        delete post_like_path(post_item, like), xhr: true
      }.to change(Like, :count).by(-1)
    end
  end
end
