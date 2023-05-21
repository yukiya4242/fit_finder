FactoryBot.define do
  factory :chat do
    association :user
    association :room
    association :sender_id, factory: :user
    association :receiver,  factory: :user
    message { "Test message" }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'image.jpeg'), 'image/jpeg') }
    video { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'video.mp4'), 'video/mp4') }

  end
end