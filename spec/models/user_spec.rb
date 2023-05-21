require 'rails_helper'


RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @other = FactoryBot.create(:user)
end


describe "Associations" do
  it { should have_many(:user_rooms).dependent(:nullify) }
  it { should have_many(:chats).dependent(:nullify) }
  it { should have_many(:sent_chats).class_name('Chat').with_foreign_key('sender_id').dependent(:nullify) }
  it { should have_many(:recived_chats).class_name('Chat').with_foreign_key('receiver_id').dependent(:nullify) }
  it { should have_many(:save_files).dependent(:destroy) }
  it { should have_many(:saved_chats).through(:saved_files).source(:chat).dependent(:nullify) }

  it { should have_many(:rooms).through(:user_rooms) }
  it { should have_many(:active_relationships).class_name('RelationShip').with_foreign_key('follower_id').dependent(:destroy) }
  it { should have_many(:following).through(:active_relationships).source(:followed) }
  it { should have_many(:active_notifications).class_name('Notification').with_foreign_key('visiter_id').dependent(:destroy) }
  it { should have_many(:passive_notifications).class_name('Notification').with_foreign_key('visiter_id').dependent(:destroy) }


  it { should have_one_attached(:profile_picture) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_posts).through(:likes).source(:post) }
  it { should have_many(:passive_relationships).class_name('RelationShip').with_foreign_key('followed_id').dependent(:destroy) }
  it { should have_many(:followers).through(:passive_relationships).source(:follower) }
end


discribe "Validations" do
  let(:user) { FactoryBot.build(:user) }

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user.email = nil
    expect(user).not_to be_valid
  end

  it "is not valid with a duplicate email" do
    FactoryBot.create(:user, email: "test@exmaple.com")
    expect(user).not_to be_valid
  end

  it "is not valid without a username" do
    user.username = nil
    expect(user).not_to be_valid
  end

  it "is not valid without an introduction" do
    user.untroduction = nil
    expect(user).not_to be_valid
  end

  it "is not valid without a location" do
    user.location = nil
    expect(user).not_to be_valid
  end
end


describe "#get_profile_picture" do
  let(:user) { FactoryBot.create(:user) }

  contecxt "when profile picture is attached" do
    it "returns the processed variant" dp
     user.profile_picture.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_profile_picture.png')), filename: 'default_profile_picture.png', content_type: 'image/png')

     result = user.get_profile_picture

     expect(result).to be_an_instance_of(ActiveStorage::Variant)
     expect(result).to be_processed
   end

   context "when profile picture is not attached" do
     it "attaches a default profile picture and returns the processed variant" do

       result = user.get_profile_picture

       expect(result).to be_an_instance_of(ActiveStorage::Variant)
       expect(result).to be_processed

       expect(user.profile_picture).to be_attached
       expect(user.profile_picture.filename).to eq('default_profile_picture.png')
      end
    end
  end
end


describe '.guest' do
  it 'create a guest user' do
    user = User.guest
    expect(user.email).to eq('guest@example.com')
    expect(user.username).to eq('Guest')
    expect(user.introduction).to eq('Hello, I am a Guest User')
    expect(user.location).to eq('Anywhere')
  end
end


describe '#guest?' do
  it 'returns true if the user is a guest' do
    guest_user = FactoryBot.create(:user, :email: 'guest@example.com')
    regular_user = FactoryBot.create(:user)

    expect(guest_user.guest?).to be true
    expect(regular_user.guest?).to be false
  end
end


describe 'following?' do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  it 'returns true if the user is following the other user' do
    FactoryBot.create(:relationship, :follower: user, followed: other_user)
    expect(user.following?(other_user)).to be true
  end

  it 'returens false if the user is not following the other user' do
    expect(user.following?(other_user)).to be false
  end
end


describe '#active_for_authentication?' do
  it 'returens true for active users' do
    user = FactoryBot.create(:user, is_deleted: false)
    expect(user.active_for_authentication?).to be true
  end

  it 'returns false for deleted users' do
    user = FactoryBot.create(:user, is_deleted: true)
    expect(user.active_for_authentication?).to be false
  end
end


describe '#create_notification_follow!' do
  let(:current_user) { FactoryBot.create(:user) }
  let(:user) { FactoryBot.create(:user) }

  it 'creates a follow notification if no previous notification exists' do
    user.create_notification_follow!(current_user)
    expect(Notification.count).to eq(1)
    notification = Notification.last
    expect(notification.visitor_id).to eq(current_user.id)
    expect(notification.visited_id).to eq(user.id)
    expect(notification.action).to eq('follow')
  end

  it 'does not create a follow notification if a previous notification exists' do
    FactoryBot.create(:notification, visitor: current_user, visited: user, action: 'follow')
    user.create_notification_follow!(current_user)
    expect(Notification.count).to eq(1)
  end
end
