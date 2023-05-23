FactoryBot.define do
  factory :room do
    after(:create) do |room|
      create(:user)
      create_list(:user_rooms, 3, room: room)
      create_list(:chat, 3, room: room)
    end

    # association :user_rooms
    # association :chats
    # association :notifications
  end
end
