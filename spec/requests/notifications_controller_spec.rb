require 'rails_helper'

RSpec.describe NotificationsController, type: :request do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:visitor) { create(:user) }
    let!(:notification1) { create(:notification, visitor: visitor, visited_id: user.id) }
    let!(:notification2) { create(:notification, visitor: visitor, visited_id: user.id) }
    let!(:notification3) { create(:notification, visitor: visitor, visited_id: user.id) }

    before do
      sign_in user
    end

    it 'assigns notifications and updates checked status' do
      get notifications_path

      expect(assigns(:notifications)).to match_array([notification1, notification2, notification3])
      expect(notification1.reload.checked).to be true
      expect(notification2.reload.checked).to be true
      expect(notification3.reload.checked).to be true
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    let(:notification) { create(:notification, visitor: user) }

    before do
      sign_in user
    end

    it 'updates the checked status of the notification' do
      patch notification_path(notification)

      expect(notification.reload.checked).to be true
      expect(response).to redirect_to(notifications_path)
    end
  end
end
