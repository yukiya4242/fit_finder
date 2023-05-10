class Chat < ApplicationRecord

  belongs_to :user
  belongs_to :room
  has_many   :notifications, dependent: :destroy

  validates :message, length: { in: 1..140 }

end
