require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe 'associations' do

    it { should belong_to(:user) }
    it { should belong_to(:room) }
    it { should belong_to(:sender).class_name('User').with_foreign_key('sender_id') }
    it { should belong_to(:receiver).class_name('User').with_foreign_key('receiver_id') }
    it { should have_many(:saved_files).dependent(:destroy) }
    it { should have_many(:saved_by_users).through(:saved_files).source(:user) }
    it { should have_many(:notifications).dependent(:destroy) }
  end


  describe 'varidation' do
    it { should validate_length_of(:message).is_at_least(1).is_at_most(140).allow_blank }
  end


 describe 'methods' do
  let(:room) { create(:room) }
  let(:user) { create(:user) }
  let(:user_room) { create(:user_room, room: room, user: user) }
  let(:chat) { create(:chat, user_room: user_room) }
  end
end