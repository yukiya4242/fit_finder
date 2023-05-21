require 'rails_helper'

RSpec.describe RelationShip, type: :model do
  describe "association" do

    it { should belong_to(:follower).class_name('User') }
    it { should belong_to(:followed).class_name('User') }
  end
end