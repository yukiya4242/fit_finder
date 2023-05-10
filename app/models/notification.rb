class Notification < ApplicationRecord

  default_scope -> { order(created_at: :desc) }
                       #{optional: true}はnilを許可する
  belongs_to :post,    optional: true
  belongs_to :comment, optional: true
  belongs_to :room,    optional: true
  belongs_to :chat,    optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visitor_id', optional: true



end
