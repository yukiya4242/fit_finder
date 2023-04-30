class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user      #ユーザー
  has_many   :comments  #コメント
end
