class Post < ApplicationRecord
  has_one_attached :image
  # after_create     :resize_image

  belongs_to :user                               #ユーザー
  has_many   :comments,      dependent: :destroy #コメント
  has_many   :likes,         dependent: :destroy #いいね
  has_many   :likers,        through:   :likes, source: :user
  has_many   :notifications, dependent: :destroy

  validates :content, length: { in: 1..140 }


  def liked_by(user)
    likes.exsits?(user_id: user.id)
  end

  # private

  # def resize_image
  #   return unless image.attached?

  #   rezised_image = MiniMagick::Image.read(image.download)
  #   resized_image.resize("400×400")

  #   image_blob = ActiveStorage::Blob.create_after_upload!(
  #     io: StringIO.new(rsized_image.to_blob),
  #     filename: image.filename,
  #     content_type: image.content_type
  #     )

  #   image.attach(image_blob)
  #   end
  end
