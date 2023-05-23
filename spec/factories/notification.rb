FactoryBot.define do
  factory :notification do
    association :visitor, factory: :user
    association :visited, factory: :user
    comment { create(:comment) }
    room { create(:room) }
    chat { create(:chat) }
    post { create(:post) }
    action { 'follow' }
    checked { false }
  end
end
