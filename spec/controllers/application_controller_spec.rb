require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin_user) }

  # Deviseのテストのための設定
  include Devise::Test::ControllerHelpers

  describe 'after_sign_in_path_for' do
    context 'when user is an admin' do
      before do
        # Adminとしてログイン
        sign_in admin
      end

      it 'redirects to the admin dashboard' do
        expect(controller.after_sign_in_path_for(admin)).to eq admin_dashboard_path
      end
    end

    context 'when user is not an admin' do
      before do
        # Userとしてログイン
        sign_in user
      end

      it 'redirects to the user page' do
        expect(controller.after_sign_in_path_for(user)).to eq user_path(user)
      end
    end
  end

  describe 'after_sign_out_path_for' do
    it 'redirects to the root path' do
      expect(controller.after_sign_out_path_for(user)).to eq root_path
    end
  end

  describe '#unchecked_notifications' do
    it 'returns unchecked notifications for the current user' do
      # ユーザーを作成し、通知を作成する
      notification = create(:notification, visited: user, checked: false)

      # ユーザーとしてログイン
      sign_in user

      # unchecked_notificationsメソッドを呼び出し、結果を確認する
      expect(controller.unchecked_notifications).to eq [notification]
    end
  end

  describe '#current_or_guest_user' do
    context 'when a user is signed in' do
      before do
        # ユーザーとしてログイン
        sign_in user
      end

      it 'returns the current user' do
        expect(controller.current_or_guest_user).to eq user
      end
    end

    context 'when no user is signed in' do
      it 'returns the guest user' do
        expect(controller.current_or_guest_user).to eq User.guest
      end
    end
  end
end
