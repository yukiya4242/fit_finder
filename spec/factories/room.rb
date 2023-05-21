FactoryBot.define do
  factory :room do

    association :user_rooms
    association :chats
    association :notifications
  end
end
