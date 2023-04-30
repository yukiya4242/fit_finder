class Comment < ApplicationRecord
  
  belongs_to :user   #ユーザー
  belongs_to :post   #投稿
end
