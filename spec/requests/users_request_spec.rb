require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }


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


  describe "GET #liked_posts" do
    context "when user is authenticated" do
      let(:user)  { create(:user) }
      let(:post1) { create(:post) }
      let(:post2) { create(:post) }

      before do
        user.likes.create(post_id: post1.id)
        sign_in user
        get liked_posts_user_path(user)
      end

      it "responds successfuly" do
        expect(response).to be_successful
      end

      it "returns a 200 response" do
        expect(response).to have_http_status "200"
      end

      it "assigns the requested liked_posts to @liked_posts" do
        expect(assigns(:liked_posts)).to match_array(user.liked_posts)
      end
    end

      context "when user is not authenticated" do
        it "redirects to login page" do
          sign_out user
          get liked_posts_user_path(user)
          expect(response).to redirect_to new_user_session_path
        end
      end
    end

    describe "PATCH #hide" do
      let(:user) { create(:user) }

      context "when user is authenticated" do
        before do
          sign_in user
          delete users_hide_user_path(user)
          expect(response).to redirect_to root_path
        end

        it "updates is_deleted to true" do
          expect(user.reload.is_deleted).to eq true
        end


        it "redirect to root_path" do
          expect(response).to redirect_to root_path
        end

        it "sets a flash message" do
          expect(flash[:notice]).to eq "ありがとうございました。またのご利用を心よりお待ちしております。"
        end
      end

      context "when user is not authenticated" do
        it "redirect to login page" do
          sign_out user
          delete users_hide_user_path(user)
          expect(response).to redirect_to root_path
        end
      end
    end


    describe "POST #follow" do
  context "when user is authenticated" do
    before do
      sign_in user
    end

    it "creates a new relationship" do
      expect do
        post follow_user_path(other_user.id)
      end.to change(user.following, :count).by(1)
    end

    it "returns a successful response" do
      post follow_user_path(other_user.id)
      expect(response).to have_http_status(:redirect)
    end
  end

  context "when user is not authenticated" do
    it "does not create a new relationship" do
      expect do
        post follow_user_path(other_user.id)
      end.to_not change(user.following, :count)
    end
  end
end

describe "DELETE #unfollow" do
  context "when user is authenticated" do
    before do
      sign_in user
      user.following << other_user
    end

    it "destroys the relationship" do
      expect do
        delete unfollow_user_path(other_user.id)
      end.to change(user.following, :count).by(-1)
    end

    it "returns a successful response" do
      delete unfollow_user_path(other_user.id)
      expect(response).to have_http_status(:redirect)
    end
  end

  context "when user is not authenticated" do
    before do
      user.following << other_user
    end

    it "does not destroy the relationship" do
      expect do
        delete unfollow_user_path(other_user.id)
      end.to_not change(user.following, :count)
    end
  end
end




end


  #無限ループになり処理できない
  # describe 'GET #chat_history' do

  #   let(:user) { create(:user) }
  #   let(:other_user_1) { create(:user) }
  #   let(:other_user_2) { create(:user) }

  #   let(:room_1) { create(:room) }
  #   let(:room_2) { create(:room) }

  #   let(:user_room_1) { create(:user_room, user: user, room: room_1) }
  #   let(:user_room_2) { create(:user_room, user: user, room: room_2) }
  #   let(:user_room_3) { create(:user_room, user: other_user_1, room: room_1) }
  #   let(:user_room_4) { create(:user_room, user: other_user_2, room: room_2) }

  #   before do
  #     user
  #     other_user_1
  #     other_user_2
  #     room_1
  #     room_2
  #     user_room_1
  #     user_room_2
  #     user_room_3
  #     user_room_4
  # end


  #   context 'when user is authenticated' do
  #     before do
  #       sign_in user
  #       get chat_history_user_path(user)
  #     end

  #     it 'assigns the current user to @user' do
  #       expect(assigns(:user)).to eq user
  #     end

  #     it 'assigns the other users in the chat room to @chat_users' do
  #       expect(assigns(:chat_users)).to match_array [other_user_1, other_user_2]
  #     end
  #   end

  #   context 'when user is not authenticated' do
  #     before do
  #       get chat_history_user_path(user)
  #     end

  #     it 'redirect to the login page' do
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end
  # end

