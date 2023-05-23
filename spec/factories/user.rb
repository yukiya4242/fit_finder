
FactoryBot.define do
  factory :user do
    username { "TestUser" }
    sequence(:email) { |n| "test#{n}@example.com" } #テストのの度ランダムでアドレスが生成される。バリデーションでエラーにならないようにする
    password { "password" }
    password_confirmation { "password" }
    introduction { "This is a test introduction" }
    location { "Test Location" }
    # assuming that profile_picture is necessary and it's an attached Active Storage object
    after(:build) do |user|
      user.profile_picture.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'example.png')), filename: 'example.png', content_type: 'image/png')
    end
  end
end
