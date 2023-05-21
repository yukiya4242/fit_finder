require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "association" do
    it { should have_many(:user_rooms) }
    it { should have_many(:chats) }
    it { should have_many(:notifications).dependent(:destroy) }
  end
end

