require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET /index" do
    context "when user is not authenticated" do
      it "redirects to login page" do
        get users_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when user is authenticated" do
      before do
        sign_in user
        get users_path
      end

      it "responds successfully" do
        expect(response).to be_successful
      end

      it "returns a 200 response" do
        expect(response).to have_http_status "200"
      end

      it "assigns the requested users to @users" do
        expect(assigns(:users)).to match_array(User.where(is_deleted: false).where.not(email: 'guest@example.com'))
      end
    end
  end

  describe 'GET #show' do
    before do
      sign_in user
      get user_path(user)
    end

    it 'responds successfully' do
      expect(response).to be_successful
    end

    it 'returns a 200 response' do
      expect(response).to have_http_status "200"
    end
  end

  describe 'GET #edit' do
    before do
      sign_in user
      get edit_user_path(user)
    end

    it 'responds successfully' do
      expect(response).to be_successful
    end

    it 'returns a 200 response' do
      expect(response).to have_http_status "200"
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before do
        sign_in user
         patch user_path(user), params: { user: { username: 'updated username' } }
      end

      it "updates the user" do
        patch user_path(user), params: { user: { username: 'updated username' } }
        expect(user.reload.username).to eq 'updated username'
      end


      it 'redirects to the user page' do
        expect(response).to redirect_to user_path(user)
      end
    end

    context 'with invalid attributes' do
      before do
        sign_in user
        patch user_path(user), params: { user: attributes_for(:user, username: nil) }
      end

      it 'does not update the user' do
        expect(user.reload.username).to_not eq nil
      end

      it 're-renders the edit template' do
        expect(response).to render_template :edit
      end
    end
  end
end
