class Post < ApplicationRecord
  has_one_attached :image                 #複数枚画像投稿

  belongs_to :user                          #ユーザー
  has_many   :comments, dependent: :destroy #コメント
  has_many   :likes,    dependent: :destroy #いいね


  def liked_by(user)
    likes.exsits?(user_id: user.id)
  end

end
