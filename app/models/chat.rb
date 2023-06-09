class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  has_many   :saved_files, dependent: :destroy
  has_many   :saved_by_users, through: :saved_files, source: :user #チャットが特定のユーザーによって保存されたかどうかの確認
  has_many   :notifications, dependent: :destroy

  has_one_attached :image
  has_one_attached :video

  validates :message, length: { in: 1..140 }, allow_blank: true
  validate :message_or_media_present?


  private

  def message_or_media_present? 
    if [message.present?, image.attached?, video.attached?].count(true) == 0
      errors.add(:base, "メッセージ、画像、またはビデオのいずれかが必要です。")
    end
  end
end
