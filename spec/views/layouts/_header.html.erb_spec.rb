# require 'rails_helper'

# RSpec.describe "layouts/_header.html.erb", type: :view do
#   before do
#     @user = FactoryBot.create(:user)
#     sign_in @user
#     render
#   end

#   it "Header Logo" do
#     expect(rendered).to have_css("img.navbar-brand")
#   end

#   it "Header Link" do
#     expect(rendered).to have_link("新規登録", href: new_user_registration_path)
#     expect(rendered).to have_link("ログイン", href: new_user_session_path)
#     expect(rendered).to have_link("マイページ", href: user_path(@user))
#     expect(rendered).to have_link("ゲストログイン", href: users_guest_sign_in_path)
#     expect(rendered).to have_link("ログアウト", href: destroy_user_session_path, method: :delete)
#   end

#   it "When login or logout" do
#     expect(rendered).to have_link("新規登録") #ログアウトしてない時も表示されるべき
#     expect(rendered).to have_link("ログイン") #ログインしてない時も表示させれるべき
#     expect(rendered).to have_link("マイページ") #ログインしている時に表示されるべき
#     expect(rendered).to have_link("ゲストログイン") #ログインしていない時に表示されるべき
#     expect(rendered).to have_link("ログアウト") #ログインしている時に表示されるべき
#   end
# end
