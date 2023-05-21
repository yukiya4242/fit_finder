require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:notifications).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_length_of(:content).is_at_least(1).is_at_most(140) }
  end

  describe '#liked_by?' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }

    context 'when the user has liked the post' do
      before do
        create(:like, user: user, post: post)
      end

      it 'returns true' do
        expect(post.liked_by?(user)).to be_truthy
      end
    end

    context 'when the user has not liked the post' do
      it 'returns false' do
        expect(post.liked_by?(user)).to be_falsey
      end
    end
  end

  describe '#create_notification_like!' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    context 'when the user likes the post for the first time' do
      it 'creates a new notification' do
        expect { post.create_notification_like!(user) }.to change { Notification.count }.by(1)
      end
    end

    context 'when the user has already liked the post' do
      before do
        post.create_notification_like!(user)
      end

      it 'does not create a new notification' do
        expect { post.create_notification_like!(user) }.not_to change { Notification.count }
      end
    end
  end
end