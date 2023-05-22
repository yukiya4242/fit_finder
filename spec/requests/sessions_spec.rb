require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }
  let(:inactive_user) { create(:user, is_deleted: true) } # ユーザーが退会済みの場合

  describe "POST /users/sign_in" do
    context "with valid credentials" do
      it "logs the user in" do
        post user_session_path, params: { user: { email: user.email, password: user.password } }
        expect(response).to redirect_to user_path(user)
        follow_redirect!
      end
    end

    context "with valid credentials but inactive user" do
      it "does not log the user in and shows error message" do
        post user_session_path, params: { user: { email: inactive_user.email, password: inactive_user.password } }
        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
      end
    end


  describe "POST /users/guest_sign_in" do
    it "logs the guest user in" do
      post users_guest_sign_in_path
      expect(response).to redirect_to(users_path)
      follow_redirect!
      expect(response.body).to include('ゲストユーザーとしてログインしました')
      end
    end
  end
end
