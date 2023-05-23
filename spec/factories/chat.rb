FactoryBot.define do
  factory :chat do
    message { "Test message" }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'image.jpeg'), 'image/jpeg') }
    video { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'video.mp4'), 'video/mp4') }
    association :room
    association :user

    after(:build) do |chat|
      chat.sender = create(:user) unless chat.sender
      chat.receiver = create(:user) unless chat.receiver
    end
  end
end
