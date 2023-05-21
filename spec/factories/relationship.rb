FactoryBot.define do
  factory :relationship, class: 'RelationShip' do
    follower { create(:user) }
    followed { create(:user) }
  end
end