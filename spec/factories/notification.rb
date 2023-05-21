FactoryBot.define do
  factory :notification do
    visitor { create(:user) }
    visited { create(:user) }
    action { 'follow' }
    checked { false }
  end
end