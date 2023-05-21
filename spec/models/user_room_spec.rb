require 'rails_helper'

RSpec.describe UserRoom, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end
end
