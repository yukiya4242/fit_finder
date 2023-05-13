class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many   :notifications, dependent: :destroy

  has_one_attached :image
  has_one_attached :video

  validates :message, length: { in: 1..140 }, allow_blank: true
  validate :only_one_type_of_attachment, :message_or_media_present?

  def read!
    self.update(read: true)
  end

  private

  def only_one_type_of_attachment
    if [message.present?, image.attached?, video.attached?].count(true) > 1
      errors.add(:base, "You can only add a message, an image, or a video.")
    end
  end

  def message_or_media_present?
    if [message.present?, image.attached?, video.attached?].count(true) == 0
      errors.add(:base, "You must provide a message, an image, or a video.")
    end
  end
end
