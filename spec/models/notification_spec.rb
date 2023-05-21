require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'associations' do
    it { should belong_to(:post).optional }
    it { should belong_to(:comment).optional }
    it { should belong_to(:room).optional }
    it { should belong_to(:chat).optional }
    it { should belong_to(:visitor).class_name('User').with_foreign_key('visitor_id').optional }
    it { should belong_to(:visited).class_name('User').with_foreign_key('visited_id').optional }
  end

  describe 'default scope' do
    it 'orders by created_at in descending order' do
      visitor = FactoryBot.create(:user)
      notification = FactoryBot.create(:notification, visitor: visitor) #ダミー通知
      expect(Notification.all).to eq([notification])
    end
  end
end
