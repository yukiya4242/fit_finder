class Comment < ApplicationRecord

  belongs_to :user   #ユーザー
  belongs_to :post   #投稿

  has_many :notifications, dependent: :destroy #通知
end
