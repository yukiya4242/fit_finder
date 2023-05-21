FactoryBot.define do
  factory :user_rooms, class: 'UserRoom' do
    association :user
    association :room
  end
end
