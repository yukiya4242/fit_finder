class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_rooms, dependent: :nullify
  has_many :chats,      dependent: :nullify
  has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id', dependent: :nullify
  has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id', dependent: :nullify
  has_many :saved_files, dependent: :destroy
  has_many :saved_chats, through: :saved_files, source: :chat, dependent: :nullify

  has_many :rooms, through: :user_rooms
  has_many :active_relationships, class_name: "RelationShip", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :active_notifications,  class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy #自分からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy #相手からの通知

  has_one_attached :profile_picture

  has_many :posts,       dependent: :destroy                #投稿
  has_many :comments,    dependent: :destroy                #コメント
  has_many :likes,       dependent: :destroy                #いいねを持つ
  has_many :liked_posts, through: :likes, source: :post     #liked_postsという名前でlikesを経由、その後postに紐づけられる

  #フォロワー
  has_many :passive_relationships, class_name: 'RelationShip', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  validates :email,           presence: true, uniqueness: true #同じアドレスは1つのみ
  validates :username,        presence: true
  # validates :profile_picture, presence: true
  validates :introduction,    presence: true
  validates :location,        presence: true

  def get_profile_picture
    unless profile_picture.attached?
      file_path = Rails.root.join('app/assets/images/ogura.png')
      profile_picture.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    # you need to define the width and height
    width, height = 100, 100
    profile_picture.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest      #ゲストログイン機能
    find_or_create_by(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = 'Guest'
      user.introduction = 'Hello, I am a Guest User'
      user.location = 'Anywhere'
    end
  end

  def guest?
    email == 'guest@example.com'
  end

  def following?(other_user)
    following.find_by(id: other_user.id).present?
  end

   # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id) unless self.following?(other_user)
  end

  # ユーザーのフォローを解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy if self.following?(other_user)
  end


  #退会ユーザーはログインできなくする
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  #フォロー通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
