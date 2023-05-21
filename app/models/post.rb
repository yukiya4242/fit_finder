class Post < ApplicationRecord
  has_one_attached :image
  has_one_attached :video


  belongs_to :user                               #ユーザー
  has_many   :comments,      dependent: :destroy #コメント
  has_many   :likes,         dependent: :destroy #いいね
  has_many   :likers,        through:   :likes, source: :user
  has_many   :notifications, dependent: :destroy

  validates :content, length: { in: 1..140 }


  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end



   #いいねの通知メソッド
    def create_notification_like!(current_user)
      #いいね済みか検証
      temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?",
                                  current_user.id, user_id, id, 'like'])
      #いいねされていない場合に通知レコードを作成
      if temp.blank?
        notification = current_user.active_notifications.new(
          post_id: id,
          visited_id: user_id,
          action: 'like'
        )
        #自分の投稿に対するいいねの場合は通知済みとする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        if notification.valid?
          notification.save
          puts "Notification has been created." # ログ出力
        else
          puts "Notification is invalid. Error messages: #{notification.errors.full_messages.join(', ')}" # ログ出力
        end
      else
        puts "Notification already exists." # ログ出力
      end
    end




  #コメントの通知メソッド
   def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
   end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end