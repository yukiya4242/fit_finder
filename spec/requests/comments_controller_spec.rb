# require 'rails_helper'

# RSpec.describe CommentsController, type: :request do
#   let(:user) { create(:user) }
#   let(:post) { create(:post) }
#   let(:comment_params) { attributes_for(:comment, user_id: user.id, post_id: post.id) }
#   let(:invalid_comment_params) { attributes_for(:comment, content: "", user_id: user.id, post_id: post.id) }

#   describe 'POST #create' do
#     before do
#       sign_in user
#     end

#     # context 'with valid parameters' do
#     #   it 'creates a new comment' do
#     #     expect {
#     #       post post_comments_path(post.id), params: { comment: comment_params }
#     #     }.to change(Comment, :count).by(1)
#     #   end
#     # end

#   #   context 'with invalid parameters' do
#   #     it 'does not create a new comment' do
#   #       expect {
#   #         post post_comments_path(post.id), params: { comment: invalid_comment_params }
#   #       }.not_to change(Comment, :count)
#   #     end
#   #   end
#   # end

#   describe 'DELETE #destroy' do
#     let!(:comment) { create(:comment, user: user, post: post) }

#     before do
#       sign_in user
#     end

#     it 'deletes the comment' do
#       expect {
#         delete post_comment_path(post.id, comment.id)
#       }.to change(Comment, :count).by(-1)
#     end
#   end
# end

